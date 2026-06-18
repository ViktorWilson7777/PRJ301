<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<layout:room pageTitle="Join Request - ${room.title}">
    <style>
        .request-container {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 100vw;
            height: 100%;
            background: radial-gradient(circle at center, #1E1B4B 0%, #0F0E17 100%);
            padding: 20px;
        }

        .request-card {
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

        .host-avatar {
            width: 90px;
            height: 90px;
            border-radius: 50%;
            background: linear-gradient(135deg, #00CEC9, #6C5CE7);
            border: 3px solid rgba(255, 255, 255, 0.1);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 36px;
            font-weight: 700;
            color: #fff;
            margin: 0 auto 20px auto;
            box-shadow: 0 0 25px rgba(108, 92, 231, 0.3);
        }

        .room-title {
            font-size: 24px;
            font-weight: 800;
            color: #fff;
            margin-bottom: 8px;
        }

        .host-name {
            font-size: 14px;
            color: #A29BFE;
            font-weight: 500;
            margin-bottom: 24px;
        }

        .meta-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px;
            margin-bottom: 24px;
        }

        .meta-item {
            background: rgba(255, 255, 255, 0.03);
            border: 1px solid rgba(255, 255, 255, 0.05);
            border-radius: 12px;
            padding: 12px;
            text-align: left;
        }

        .meta-label {
            font-size: 10px;
            color: #94A1B2;
            text-transform: uppercase;
            font-weight: 600;
            margin-bottom: 4px;
        }

        .meta-value {
            font-size: 13px;
            color: #E2E8F0;
            font-weight: 600;
        }

        .room-desc {
            font-size: 13px;
            color: #94A1B2;
            line-height: 1.6;
            margin-bottom: 30px;
            background: rgba(0, 0, 0, 0.15);
            border-radius: 12px;
            padding: 16px;
            text-align: left;
        }

        .form-dark {
            background: rgba(0, 0, 0, 0.25);
            border: 1px solid rgba(255, 255, 255, 0.1);
            color: #fff;
            border-radius: 12px;
            padding: 10px 16px;
            font-size: 14px;
            outline: none;
            width: 100%;
            margin-bottom: 20px;
        }

        .form-dark:focus {
            border-color: #6C5CE7;
            box-shadow: 0 0 10px rgba(108, 92, 231, 0.2);
        }

        .btn-submit {
            background: linear-gradient(135deg, #6C5CE7, #818CF8);
            color: #fff;
            border: none;
            border-radius: 12px;
            padding: 12px 24px;
            font-weight: 600;
            width: 100%;
            transition: 0.2s;
        }

        .btn-submit:hover {
            box-shadow: 0 0 15px rgba(108, 92, 231, 0.4);
            transform: translateY(-1px);
        }

        .btn-back {
            background: transparent;
            color: #94A1B2;
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 12px;
            padding: 10px 24px;
            font-weight: 500;
            font-size: 13px;
            width: 100%;
            margin-top: 12px;
            text-decoration: none;
            display: inline-block;
            transition: 0.2s;
        }

        .btn-back:hover {
            background: rgba(255, 255, 255, 0.05);
            color: #fff;
        }
    </style>

    <div class="request-container">
        <div class="request-card">
            <div class="host-avatar">
                ${room.hostUser != null ? room.hostUser.displayName.substring(0,1).toUpperCase() : 'H'}
            </div>
            <h3 class="room-title">${room.title}</h3>
            <div class="host-name">Hosted by ${room.hostUser != null ? room.hostUser.displayName : 'Unknown'}</div>

            <c:if test="${denied}">
                <div class="alert alert-danger border-0 p-3 mb-4 text-start" style="background: rgba(239, 68, 68, 0.1); border-radius: 12px;">
                    <div style="font-size: 12px; font-weight: 700;" class="text-danger mb-1"><i class="bi bi-exclamation-triangle-fill me-1"></i> REQUEST DENIED</div>
                    <div style="font-size: 11px; color: #FCA5A5;">Your previous request was denied by the Host. You can modify your role choice and resubmit.</div>
                </div>
            </c:if>

            <div class="meta-grid">
                <div class="meta-item">
                    <div class="meta-label">Language</div>
                    <div class="meta-value">${room.languageCode != null ? room.languageCode : 'English'}</div>
                </div>
                <div class="meta-item">
                    <div class="meta-label">Level</div>
                    <div class="meta-value">Level ${room.levelNumber != null ? room.levelNumber : '1'}</div>
                </div>
            </div>

            <div class="room-desc">
                <div style="font-size: 10px; font-weight: 700; color: #94A1B2; margin-bottom: 4px; text-transform: uppercase;">About this room</div>
                <div style="color: #CBD5E1;">${room.description != null && !room.description.isBlank() ? room.description : 'Join us for an immersive speaking and listening experience.'}</div>
            </div>

            <div class="text-start mb-2">
                <label class="form-label text-muted" style="font-size: 11px; font-weight: 600; text-transform: uppercase; margin-left: 4px;">Choose your role</label>
                <select id="roleRequested" class="form-dark">
                    <option value="LISTENER">Audience (Listen & Text Chat)</option>
                    <option value="SPEAKER">Speaker (Actively speak on stage)</option>
                </select>
            </div>

            <button id="btnRequest" class="btn-submit">Send Request to Join</button>
            <a href="/rooms" class="btn-back">Back to Rooms</a>
        </div>
    </div>

    <script>
        document.getElementById('btnRequest').onclick = function() {
            const btn = this;
            btn.disabled = true;
            btn.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Sending...';

            const userId = '${sessionScope.currentUser.id}';
            const roomId = '${room.id}';
            const roleRequested = document.getElementById('roleRequested').value;

            fetch('/api/rooms/' + roomId + '/request-join?userId=' + userId + '&roleRequested=' + roleRequested, {
                method: 'POST'
            })
            .then(res => res.json())
            .then(data => {
                if (data.error) {
                    alert("Yêu cầu thất bại: " + data.error);
                    btn.disabled = false;
                    btn.innerHTML = 'Send Request to Join';
                } else {
                    // Reload to trigger roomDetail logic, which will now show room-waiting.jsp
                    window.location.reload();
                }
            })
            .catch(err => {
                alert("Lỗi kết nối: " + err);
                btn.disabled = false;
                btn.innerHTML = 'Send Request to Join';
            });
        };
    </script>
</layout:room>
