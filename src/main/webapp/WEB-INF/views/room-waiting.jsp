<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<layout:room pageTitle="Waiting Approval - ${room.title}">
    <style>
        .waiting-container {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 100vw;
            height: 100%;
            background: radial-gradient(circle at center, #1E1B4B 0%, #0F0E17 100%);
            padding: 20px;
        }

        .waiting-card {
            background: rgba(30, 27, 75, 0.4);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.08);
            border-radius: 24px;
            padding: 40px;
            max-width: 480px;
            width: 100%;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.4);
            text-align: center;
        }

        .waiting-loader {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            border: 4px solid rgba(108, 92, 231, 0.1);
            border-top-color: #6C5CE7;
            animation: spin-loader 1.2s cubic-bezier(0.5, 0, 0.5, 1) infinite;
            margin: 0 auto 30px auto;
            position: relative;
        }

        .waiting-loader::after {
            content: '';
            position: absolute;
            top: 6px;
            left: 6px;
            right: 6px;
            bottom: 6px;
            border-radius: 50%;
            border: 4px solid rgba(0, 206, 201, 0.1);
            border-top-color: #00CEC9;
            animation: spin-loader 2.4s linear infinite;
        }

        @keyframes spin-loader {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .waiting-title {
            font-size: 22px;
            font-weight: 800;
            color: #fff;
            margin-bottom: 12px;
        }

        .waiting-subtitle {
            font-size: 14px;
            color: #A29BFE;
            margin-bottom: 24px;
            line-height: 1.5;
        }

        .info-box {
            background: rgba(255, 255, 255, 0.03);
            border: 1px solid rgba(255, 255, 255, 0.05);
            border-radius: 16px;
            padding: 16px;
            margin-bottom: 30px;
            text-align: left;
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 8px;
            font-size: 13px;
        }

        .info-row:last-child {
            margin-bottom: 0;
        }

        .info-label {
            color: #94A1B2;
        }

        .info-value {
            color: #E2E8F0;
            font-weight: 600;
        }

        .btn-cancel {
            background: rgba(239, 68, 68, 0.1);
            color: #FCA5A5;
            border: 1px solid rgba(239, 68, 68, 0.2);
            border-radius: 12px;
            padding: 10px 24px;
            font-weight: 500;
            font-size: 13px;
            width: 100%;
            text-decoration: none;
            display: inline-block;
            transition: 0.2s;
        }

        .btn-cancel:hover {
            background: rgba(239, 68, 68, 0.2);
            color: #fff;
        }
    </style>

    <div class="waiting-container">
        <div class="waiting-card">
            <div class="waiting-loader"></div>
            <h3 class="waiting-title">Waiting for host approval</h3>
            <p class="waiting-subtitle">Your request to join this session has been sent. Please wait while the host reviews your entry request.</p>

            <div class="info-box">
                <div class="info-row">
                    <span class="info-label">Room</span>
                    <span class="info-value">${room.title}</span>
                </div>
                <div class="info-row">
                    <span class="info-label">Host</span>
                    <span class="info-value">${room.hostUser != null ? room.hostUser.displayName : 'Unknown'}</span>
                </div>
                <div class="info-row">
                    <span class="info-label">Requested Role</span>
                    <span class="info-value" style="color: #00CEC9;">${request.roleRequested}</span>
                </div>
            </div>

            <a href="/rooms" class="btn-cancel">Cancel & Exit</a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/stompjs@2.3.3/lib/stomp.min.js"></script>
    <script>
        const roomId = '${room.id}';
        const currentUser = '${request.displayName}';

        var socket = new SockJS('/ws');
        var stompClient = Stomp.over(socket);
        stompClient.debug = null;

        stompClient.connect({}, function (frame) {
            stompClient.subscribe('/topic/room/' + roomId, function (message) {
                var msg = JSON.parse(message.body);
                if ((msg.type === 'JOIN_APPROVED' || msg.type === 'JOIN_DENIED') && msg.senderName === currentUser) {
                    window.location.reload();
                }
            });

            // Gửi thông báo có yêu cầu tham gia mới qua WebSocket để Host nhận ngay lập tức
            stompClient.send('/app/room/' + roomId, {}, JSON.stringify({
                type: 'JOIN_REQUEST',
                senderName: currentUser,
                content: '${request.roleRequested}'
            }));
        });

        function checkStatus() {
            fetch('/api/rooms/' + roomId + '/request-status')
                .then(res => {
                    if (res.status === 401) {
                        window.location.href = '/login';
                        return;
                    }
                    if (res.status === 404) {
                        window.location.href = '/rooms';
                        return;
                    }
                    return res.json();
                })
                .then(data => {
                    if (!data) return;
                    if (data.status === 'APPROVED' || data.status === 'DENIED') {
                        window.location.reload();
                    }
                })
                .catch(err => {
                    console.error("Error polling request status:", err);
                });
        }

        // Fallback polling mỗi 10 giây
        const poller = setInterval(checkStatus, 10000);

        window.addEventListener('beforeunload', () => {
            clearInterval(poller);
            if (stompClient !== null) {
                stompClient.disconnect();
            }
        });
    </script>
</layout:room>
