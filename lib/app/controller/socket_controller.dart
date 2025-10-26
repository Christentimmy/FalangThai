// ignore_for_file: library_prefixes

import 'dart:async';
import 'package:falangthai/app/controller/message_controller.dart';
import 'package:falangthai/app/controller/storage_controller.dart';
import 'package:falangthai/app/controller/user_controller.dart';
import 'package:falangthai/app/data/models/chat_list_model.dart';
import 'package:falangthai/app/data/models/message_model.dart';
import 'package:falangthai/app/routes/app_routes.dart';
import 'package:falangthai/app/utils/base_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketController extends GetxController {
  IO.Socket? socket;
  // RxList<LiveStreamChatModel> chatMessages = <LiveStreamChatModel>[].obs;
  RxBool isloading = false.obs;
  // final _storyController = Get.find<StoryController>();

  int _reconnectAttempts = 0;
  final int _maxReconnectAttempts = 5;

  Future<void> initializeSocket() async {
    String? token = await StorageController().getToken();
    if (token == null) {
      return;
    }

    socket = IO.io(baseUrl, <String, dynamic>{
      'transports': ['websocket'],
      'extraHeaders': {'Authorization': 'Bearer $token'},
      'reconnection': true,
      "forceNew": true,
    });

    socket?.connect();

    socket?.onConnect((_) async {
      getOnlineUser();
      const prefs = FlutterSecureStorage();
      final channelName = await prefs.read(key: 'channelName');
      if (channelName != null && channelName.isNotEmpty) {
        await Future.delayed(const Duration(seconds: 3), () {
          joinStream(channelName);
        });
      }

      listenToEvents();
    });

    socket?.onDisconnect((_) {
      print("Socket disconnected");
      scheduleReconnect();
      if (_reconnectAttempts >= _maxReconnectAttempts) {
        disConnectListeners();
      }
    });

    socket?.on('connect_error', (_) {
      print("Connection error");
      scheduleReconnect();
    });
  }

  void listenToEvents() {
    socket?.on("refresh", (data) async {
      final userController = Get.find<UserController>();
      await userController.getUserDetails();
    });

    socket?.on("update-online-chat-list", (data) {
      final response = List.from(data);
      Get.find<MessageController>().activeFriends.clear();
      if (response.isEmpty) return;
      List<ChatListModel> mapped =
          response.map((e) => ChatListModel.fromJson(e)).toList();
      Get.find<MessageController>().activeFriends.value = mapped;
      Get.find<MessageController>().activeFriends.refresh();
    });

    socket?.on("update-chat-list", (data) {
      Get.find<MessageController>().getChatList(showLoading: false);
    });

    socket?.on("user-offline", (data) {
      final userId = data["userId"] as String;
      Get.find<MessageController>()
          .activeFriends
          .removeWhere((e) => e.userId == userId);
      Get.find<MessageController>().activeFriends.refresh();
      final index = Get.find<MessageController>()
          .allChattedUserList
          .indexWhere((e) => e.userId == userId);
      if (index != -1) {
        Get.find<MessageController>().allChattedUserList[index].online = false;
        Get.find<MessageController>().allChattedUserList.refresh();
      }
    });

    socket?.on("update-unread-count", (data) {
      // Get.find<MessageController>().getChatList(showLoading: false);
    });

    socket?.on("receive-message", (data) {
      final message = Map<String, dynamic>.from(data);
      final messageModel = MessageModel.fromJson(message);
      final messageController = Get.find<MessageController>();

      // Check if the message already exists to avoid duplicates
      final exists = messageController.chatHistoryAndLiveMessage
          .any((msg) => msg.id == messageModel.id);

      if (exists) return;
      final index = messageController.chatHistoryAndLiveMessage.indexWhere(
        (msg) => msg.clientGeneratedId == messageModel.clientGeneratedId,
      );
      if (index != -1) {
        messageController.chatHistoryAndLiveMessage[index].mediaUrl =
            messageModel.mediaUrl;
        messageController.chatHistoryAndLiveMessage[index].multipleImages =
            messageModel.multipleImages;
        messageController.chatHistoryAndLiveMessage[index].id = messageModel.id;
        messageController.chatHistoryAndLiveMessage[index].avater =
            messageModel.avater;
        messageController.chatHistoryAndLiveMessage[index].createdAt =
            messageModel.createdAt;
        messageController.chatHistoryAndLiveMessage.refresh();
      } else {
        messageController.chatHistoryAndLiveMessage.add(messageModel);
      }
    });

    socket?.on("error", (data) {
      String error = data["message"] ?? "";
      if (error.contains("limit")) {
        Get.toNamed(AppRoutes.subscription);
      }
    });
  }

  void getOnlineUser() {
    if (socket != null && socket!.connected) {
      socket?.emit("user-online");
    }
  }

  void sendMessage({required MessageModel message}) {
    if (socket != null && socket!.connected) {
      socket?.emit("send-message", message.toJson());
    }
  }

  void markMessageRead(String receiverId) {
    if (socket != null && socket!.connected) {
      socket?.emit("mark-message-read", {"receiverId": receiverId});
    }
  }

  void typing({required String receiverId}) {
    if (socket != null && socket!.connected) {
      socket?.emit("typing", {"receiverId": receiverId});
    }
  }

  void stopTyping({required String receiverId}) {
    if (socket != null && socket!.connected) {
      socket?.emit("stop-typing", {"receiverId": receiverId});
    }
  }

  void disConnectListeners() async {
    if (socket != null) {
      socket?.off("newChatMessage");
      socket?.off("new-story");
      socket?.off("newstream");
      socket?.off("endedStream");
      socket?.off("viewer-count-updated");
      socket?.off("refresh");
      socket?.off("update-online-chat-list");
      socket?.off("receive-message");
      socket?.off("update-chat-list");
      socket?.off("update-unread-count");
    }
  }

  void disconnectSocket() {
    disConnectListeners();
    socket?.disconnect();
    socket = null;
    socket?.close();
    print('Socket disconnected and deleted');
  }

  void getChatHistory(String rideId) {
    socket?.emit("history", {"rideId": rideId});
  }

  void markRead({
    required String channedId,
    required String messageId,
  }) async {
    socket?.emit("MARK_MESSAGE_READ", {
      "channel_id": channedId,
      "message_ids": [messageId],
    });
  }

  void scheduleReconnect() {
    if (_reconnectAttempts >= _maxReconnectAttempts) {
      debugPrint("🚨 Max reconnection attempts reached. Stopping retry.");
      return;
    }

    int delay = 2 * _reconnectAttempts + 2;
    debugPrint("🔄 Reconnecting in $delay seconds...");

    Future.delayed(Duration(seconds: delay), () {
      _reconnectAttempts++;
      socket?.connect();
    });
  }

  void joinStream(String channelName) {
    if (socket == null || !socket!.connected) {
      print("Socket is not connected");
      return;
    }

    if (channelName.isEmpty) {
      print("Invalid channelName");
      return;
    }

    print("Emitting joinStream event for channel: $channelName");
    socket?.emit('joinStream', {"channelName": channelName});
  }

  void sendChatMessage(
    String channelName,
    String message,
    String currentUserId,
  ) {
    socket?.emit('sendChatMessage', {
      'channelName': channelName,
      'userId': currentUserId,
      'message': message,
    });
  }

  @override
  void onClose() {
    socket?.dispose();
    super.onClose();
    socket = null;
  }
}
