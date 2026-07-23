<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
        <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

            <layout:room pageTitle="${room.title}" roomId="${room.id}">

                <style>
                    /* ── TIKTOK LIVE STYLE OVERRIDES ── */
                    .stream-area {
                        position: relative;
                        background: radial-gradient(circle at center, #1E1B4B 0%, #0F0E17 100%);
                        height: 100%;
                        display: flex;
                        flex-direction: column;
                        justify-content: center;
                        align-items: center;
                        overflow: hidden;
                    }

                    .chat-area {
                        background: rgba(15, 14, 23, 0.95);
                        border-left: 1px solid rgba(255, 255, 255, 0.08);
                        height: 100%;
                        display: flex;
                        flex-direction: column;
                        position: relative;
                    }

                    /* ── OVERLAYS TRÊN STREAM ── */
                    .stream-header-overlay {
                        position: absolute;
                        top: 20px;
                        left: 24px;
                        right: 24px;
                        display: flex;
                        justify-content: space-between;
                        align-items: flex-start;
                        z-index: 10;
                    }

                    .host-badge {
                        background: rgba(0, 0, 0, 0.4);
                        backdrop-filter: blur(8px);
                        border-radius: 40px;
                        padding: 6px 16px 6px 6px;
                        display: flex;
                        align-items: center;
                        gap: 10px;
                        border: 1px solid rgba(255, 255, 255, 0.1);
                    }

                    .host-avatar-mini {
                        width: 36px;
                        height: 36px;
                        border-radius: 50%;
                        background: linear-gradient(135deg, #00CEC9, #6C5CE7);
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-weight: 700;
                        color: #fff;
                        font-size: 16px;
                    }

                    .host-info {
                        display: flex;
                        flex-direction: column;
                    }

                    .host-name {
                        font-size: 14px;
                        font-weight: 700;
                        color: #fff;
                        line-height: 1.2;
                    }

                    .room-topic {
                        font-size: 11px;
                        color: #A29BFE;
                        font-weight: 500;
                    }

                    .live-stats {
                        display: flex;
                        gap: 8px;
                    }

                    .stat-pill {
                        background: rgba(0, 0, 0, 0.4);
                        backdrop-filter: blur(8px);
                        padding: 6px 12px;
                        border-radius: 20px;
                        font-size: 12px;
                        font-weight: 600;
                        color: #fff;
                        display: flex;
                        align-items: center;
                        gap: 6px;
                    }

                    .stat-pill.live {
                        background: rgba(239, 68, 68, 0.8);
                    }

                    /* ── SÂN KHẤU (NETWORK LAYOUT) ── */
                    .stage-container {
                        position: relative;
                        flex-grow: 1;
                        width: 100%;
                        overflow: hidden;
                    }

                    #network-lines-svg {
                        position: absolute;
                        top: 0;
                        left: 0;
                        width: 100%;
                        height: 100%;
                        z-index: 1;
                        pointer-events: none;
                    }

                    .host-node-wrapper {
                        position: absolute;
                        top: 50%;
                        left: 50%;
                        transform: translate(-50%, -50%);
                        z-index: 10;
                    }

                    .speaker-node-wrapper {
                        position: absolute;
                        z-index: 15;
                        transition: all 0.5s ease-in-out;
                        /* Initial position at center, will move out via JS */
                        top: 50%;
                        left: 50%;
                        transform: translate(-50%, -50%);
                        opacity: 0; 
                    }

                    .listeners-box {
                        position: absolute;
                        bottom: 100px;
                        right: 20px;
                        background: rgba(0, 0, 0, 0.4);
                        backdrop-filter: blur(10px);
                        border: 1px solid rgba(255, 255, 255, 0.1);
                        border-radius: 12px;
                        padding: 12px;
                        z-index: 20;
                        max-width: 250px;
                        max-height: 200px;
                        overflow-y: auto;
                    }
                    .listeners-box::-webkit-scrollbar { width: 4px; }
                    .listeners-box::-webkit-scrollbar-thumb { background: rgba(255,255,255,0.2); border-radius: 4px; }

                    .listeners-box h6 {
                        color: #fff;
                        font-size: 12px;
                        margin-bottom: 8px;
                        font-weight: 600;
                    }

                    .listeners-grid {
                        display: flex;
                        flex-direction: column;
                        gap: 8px;
                    }

                    .listener-item {
                        display: flex;
                        align-items: center;
                        gap: 8px;
                    }

                    .listener-name {
                        color: #E2E8F0;
                        font-size: 13px;
                        white-space: nowrap;
                        overflow: hidden;
                        text-overflow: ellipsis;
                        max-width: 150px;
                    }

                    .listener-avatar {
                        width: 28px;
                        height: 28px;
                        border-radius: 50%;
                        background: rgba(108, 92, 231, 0.6);
                        color: #fff;
                        font-size: 12px;
                        font-weight: 600;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        border: 1px solid rgba(255,255,255,0.2);
                        flex-shrink: 0;
                    }

                    .host-avatar-big {
                        width: 100px;
                        height: 100px;
                        border-radius: 50%;
                        background: linear-gradient(135deg, #00CEC9, #6C5CE7);
                        border: 4px solid #fff;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 40px;
                        font-weight: 700;
                        color: #fff;
                        position: relative;
                        box-shadow: 0 0 40px rgba(108, 92, 231, 0.4);
                        animation: pulse-avatar 2s infinite;
                    }

                    @keyframes pulse-avatar {
                        0% {
                            box-shadow: 0 0 0 0 rgba(108, 92, 231, 0.6);
                        }

                        70% {
                            box-shadow: 0 0 0 25px rgba(108, 92, 231, 0);
                        }

                        100% {
                            box-shadow: 0 0 0 0 rgba(108, 92, 231, 0);
                        }
                    }

                    .speaker-avatar {
                        width: 80px;
                        height: 80px;
                        border-radius: 50%;
                        background: #2D2B47;
                        border: 2px solid rgba(255, 255, 255, 0.2);
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 28px;
                        font-weight: 600;
                        color: #fff;
                        position: relative;
                    }

                    .mic-icon-stage {
                        position: absolute;
                        bottom: 0;
                        right: 0;
                        width: 24px;
                        height: 24px;
                        background: #10B981;
                        border-radius: 50%;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 12px;
                        color: #fff;
                        border: 2px solid #0F0E17;
                    }

                    /* ── FLOATING ACTION BAR ── */
                    .floating-action-bar {
                        position: absolute;
                        bottom: 30px;
                        left: 50%;
                        transform: translateX(-50%);
                        background: rgba(0, 0, 0, 0.6);
                        backdrop-filter: blur(12px);
                        padding: 12px 24px;
                        border-radius: 40px;
                        display: flex;
                        gap: 16px;
                        border: 1px solid rgba(255, 255, 255, 0.1);
                        z-index: 10;
                    }

                    .fab-btn {
                        width: 48px;
                        height: 48px;
                        border-radius: 50%;
                        background: rgba(255, 255, 255, 0.1);
                        border: none;
                        color: #fff;
                        font-size: 20px;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        transition: 0.2s;
                        position: relative;
                    }

                    .fab-btn:hover {
                        background: rgba(255, 255, 255, 0.2);
                        transform: scale(1.05);
                    }

                    .fab-btn.primary {
                        background: linear-gradient(135deg, #FD79A8, #E84393);
                    }

                    .fab-btn.primary:hover {
                        box-shadow: 0 0 15px rgba(232, 67, 147, 0.6);
                    }

                    /* ── CHAT SIDEBAR ── */
                    .chat-messages {
                        flex-grow: 1;
                        flex-shrink: 1;
                        overflow-y: auto;
                        padding: 20px;
                        display: flex;
                        flex-direction: column;
                        gap: 12px;
                        scrollbar-width: none;
                    }

                    .chat-messages::-webkit-scrollbar {
                        display: none;
                    }

                    .chat-msg {
                        font-size: 13px;
                        color: #E2E8F0;
                        line-height: 1.4;
                        background: rgba(255, 255, 255, 0.03);
                        padding: 8px 12px;
                        border-radius: 12px;
                        width: fit-content;
                        max-width: 90%;
                    }

                    .chat-msg span.user {
                        color: #A29BFE;
                        font-weight: 600;
                        margin-right: 6px;
                    }

                    .chat-msg.gift-alert {
                        background: rgba(253, 121, 168, 0.15);
                        border: 1px solid rgba(253, 121, 168, 0.3);
                        color: #FFE4E6;
                    }

                    .chat-msg.system-alert {
                        color: #00CEC9;
                        font-style: italic;
                        background: transparent;
                        padding: 4px 0;
                    }

                    .chat-input-area {
                        flex-shrink: 0;
                        padding: 16px;
                        border-top: 1px solid rgba(255, 255, 255, 0.08);
                        display: flex;
                        gap: 10px;
                        background: rgba(15, 14, 23, 0.95);
                    }

                    .chat-input {
                        flex: 1;
                        background: rgba(255, 255, 255, 0.08);
                        border: 1px solid rgba(255, 255, 255, 0.1);
                        color: #fff;
                        border-radius: 20px;
                        padding: 8px 16px;
                        font-size: 13px;
                        outline: none;
                    }

                    .chat-input:focus {
                        border-color: #6C5CE7;
                    }

                    .btn-send {
                        background: #6C5CE7;
                        color: #fff;
                        border: none;
                        width: 38px;
                        height: 38px;
                        border-radius: 50%;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                    }

                    /* ── OFFCANVAS HOST TOOLS ── */
                    .host-tools-panel {
                        background: #1A1929;
                        color: #E2E8F0;
                        border-left: 1px solid rgba(255, 255, 255, 0.1);
                    }

                    .host-tools-panel .offcanvas-header {
                        border-bottom: 1px solid rgba(255, 255, 255, 0.05);
                    }

                    .tool-module {
                        background: rgba(255, 255, 255, 0.03);
                        border: 1px solid rgba(255, 255, 255, 0.05);
                        border-radius: 12px;
                        padding: 16px;
                        margin-bottom: 16px;
                    }

                    .tool-module h6 {
                        font-size: 12px;
                        color: #94A1B2;
                        text-transform: uppercase;
                        font-weight: 600;
                        margin-bottom: 12px;
                        letter-spacing: 0.5px;
                    }

                    .form-dark {
                        background: rgba(0, 0, 0, 0.2);
                        border: 1px solid rgba(255, 255, 255, 0.1);
                        color: #fff;
                        border-radius: 8px;
                    }

                    @media (max-width: 991.98px) {
                        .stream-area {
                            width: 100% !important;
                            flex: 0 0 100% !important;
                            max-width: 100% !important;
                            height: 50vh !important;
                        }
                        .chat-area {
                            width: 100% !important;
                            flex: 0 0 100% !important;
                            max-width: 100% !important;
                            height: 50vh !important;
                            border-top: 1px solid rgba(255, 255, 255, 0.1);
                            border-left: none !important;
                        }
                    }

                </style>

                <style>
                    /* LUCY Live visual system: clearer hierarchy, contrast and spacing */
                    .stream-area {
                        isolation: isolate;
                        background:
                            radial-gradient(circle at 50% 42%, rgba(76, 61, 190, .24), transparent 34%),
                            radial-gradient(circle at 12% 12%, rgba(34, 211, 238, .09), transparent 25%),
                            linear-gradient(145deg, #080c18 0%, #0b1020 48%, #0d1225 100%) !important;
                    }
                    .stream-area::before {
                        content: "";
                        position: absolute;
                        inset: 0;
                        pointer-events: none;
                        z-index: 0;
                        opacity: .22;
                        background-image:
                            linear-gradient(rgba(148,163,184,.08) 1px, transparent 1px),
                            linear-gradient(90deg, rgba(148,163,184,.08) 1px, transparent 1px);
                        background-size: 44px 44px;
                        mask-image: radial-gradient(circle at center, #000 10%, transparent 76%);
                    }
                    .stream-header-overlay { top: 18px; left: 20px; right: 20px; gap: 14px; }
                    .host-badge {
                        min-height: 48px;
                        padding: 6px 14px 6px 6px;
                        background: rgba(9, 14, 28, .82) !important;
                        border: 1px solid rgba(148, 163, 184, .2) !important;
                        box-shadow: 0 12px 30px rgba(0, 0, 0, .24);
                        backdrop-filter: blur(18px);
                    }
                    .host-avatar-mini { width: 36px; height: 36px; background: linear-gradient(145deg, #22d3ee, #7c5cff); }
                    .host-name { font-size: 13px; color: #f8fafc; }
                    .room-topic { color: #94a3b8; max-width: 250px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
                    .live-stats { justify-content: flex-end; flex-wrap: wrap; }
                    .stat-pill {
                        min-height: 32px;
                        padding: 7px 11px;
                        background: rgba(15, 23, 42, .84) !important;
                        border: 1px solid rgba(148, 163, 184, .16);
                        color: #dbeafe;
                        box-shadow: 0 8px 22px rgba(0, 0, 0, .2);
                    }
                    .stat-pill.live { background: rgba(190, 24, 93, .88) !important; border-color: rgba(251,113,133,.4); }
                    .stage-container { padding: 72px 24px 94px; }
                    .host-node-wrapper { top: 48%; }
                    #network-lines-svg { opacity: .62; }
                    .host-avatar-big {
                        width: 108px;
                        height: 108px;
                        font-size: 42px;
                        background: linear-gradient(145deg, #155e75, #4f46e5);
                        border: 4px solid rgba(224, 231, 255, .82);
                        box-shadow: 0 0 0 10px rgba(124,92,255,.1), 0 24px 60px rgba(0,0,0,.35);
                        animation: live-breathe 3s ease-in-out infinite;
                    }
                    @keyframes live-breathe {
                        0%, 100% { box-shadow: 0 0 0 8px rgba(124,92,255,.08), 0 24px 60px rgba(0,0,0,.35); }
                        50% { box-shadow: 0 0 0 16px rgba(124,92,255,.035), 0 24px 68px rgba(79,70,229,.28); }
                    }
                    .speaker-avatar {
                        width: 78px;
                        height: 78px;
                        color: #f8fafc;
                        background: linear-gradient(145deg, #1e293b, #202944);
                        border: 2px solid rgba(165,180,252,.35);
                        box-shadow: 0 14px 34px rgba(0,0,0,.3);
                    }
                    .mic-icon-stage { border: 3px solid #0b1020; box-shadow: 0 5px 14px rgba(0,0,0,.35); }
                    .host-node-wrapper .text-center > div:first-child,
                    .speaker-node-wrapper .text-center > div:first-child {
                        padding: 4px 9px !important;
                        color: #f8fafc !important;
                        background: rgba(7,11,22,.82) !important;
                        border: 1px solid rgba(148,163,184,.14);
                        border-radius: 9px !important;
                        box-shadow: 0 8px 18px rgba(0,0,0,.2);
                    }
                    .listeners-box {
                        right: 18px;
                        bottom: 92px;
                        width: 208px;
                        max-width: calc(100% - 36px);
                        padding: 12px;
                        background: rgba(9, 14, 28, .82);
                        border: 1px solid rgba(148,163,184,.18);
                        border-radius: 16px;
                        box-shadow: 0 18px 44px rgba(0,0,0,.28);
                    }
                    .listeners-box h6 { color: #cbd5e1; text-transform: uppercase; letter-spacing: .08em; font-size: 10px; }
                    .listener-item { padding: 6px 7px; border-radius: 10px; background: rgba(148,163,184,.06); }
                    .listener-avatar { background: linear-gradient(145deg, #4f46e5, #7c3aed); border: 0; }
                    .listener-name { color: #dbe4f0; font-size: 12px; }
                    .floating-action-bar {
                        bottom: 18px;
                        padding: 8px;
                        gap: 8px;
                        border-radius: 20px;
                        background: rgba(7, 11, 22, .88);
                        border: 1px solid rgba(148,163,184,.18);
                        box-shadow: 0 20px 50px rgba(0,0,0,.42);
                        backdrop-filter: blur(20px);
                    }
                    .fab-btn {
                        width: 58px;
                        height: 52px;
                        border-radius: 14px;
                        flex-direction: column;
                        gap: 2px;
                        color: #cbd5e1;
                        font-size: 17px;
                        background: rgba(148,163,184,.09);
                        border: 1px solid transparent;
                    }
                    .fab-btn:hover { color: #fff; background: rgba(124,92,255,.2); border-color: rgba(165,180,252,.28); transform: translateY(-2px); }
                    .fab-btn.primary { background: linear-gradient(145deg, #7c3aed, #db2777); color: #fff; }
                    .fab-label { display: block; font-size: 9px; line-height: 1; font-weight: 700; letter-spacing: .02em; }
                    #btnRaiseHand::after { content: "Raise"; display: block; font-size: 9px; line-height: 1; font-weight: 700; }
                    .chat-area {
                        background: #0d1424 !important;
                        border-left: 1px solid rgba(148,163,184,.14) !important;
                        box-shadow: -14px 0 34px rgba(0,0,0,.12);
                    }
                    .console-header { min-height: 58px; padding: 13px 16px; border-bottom: 1px solid rgba(148,163,184,.14); }
                    .console-title { color: #f8fafc; font-size: 13px; font-weight: 700; }
                    .console-subtitle { color: #718096; font-size: 10px; margin-top: 2px; }
                    .chat-messages { padding: 14px; gap: 9px; scrollbar-width: thin; scrollbar-color: #334155 transparent; }
                    .chat-messages::-webkit-scrollbar { display: block; width: 5px; }
                    .chat-messages::-webkit-scrollbar-thumb { background: #334155; border-radius: 99px; }
                    .chat-msg {
                        width: 100%;
                        max-width: 100%;
                        padding: 10px 11px;
                        border-radius: 12px;
                        color: #d7e0ec;
                        background: rgba(30,41,59,.68);
                        border: 1px solid rgba(148,163,184,.1);
                    }
                    .chat-msg.system-alert { padding: 10px 11px; color: #a5f3fc; background: rgba(8,145,178,.1); border-color: rgba(34,211,238,.16); font-style: normal; }
                    .chat-input-area { padding: 12px; background: #0b1220; border-top-color: rgba(148,163,184,.14); }
                    .chat-input { min-height: 40px; border-radius: 12px; background: #151f34; border-color: rgba(148,163,184,.17); color: #f8fafc; }
                    .chat-input::placeholder { color: #64748b; }
                    .chat-input:focus { border-color: #7c5cff; box-shadow: 0 0 0 3px rgba(124,92,255,.12); }
                    .btn-send { width: 40px; height: 40px; border-radius: 12px; background: linear-gradient(145deg, #6d5dfc, #7c3aed); }
                    .host-tools-panel { --bs-offcanvas-width: clamp(390px, 25vw, 420px); background: #0b1220; color: #dce5f1; border-left: 1px solid rgba(148,163,184,.16); }
                    .host-tools-panel .offcanvas-header { position: sticky; top: 0; z-index: 2; min-height: 64px; padding: 15px 18px; background: #0d1526; border-bottom-color: rgba(148,163,184,.15); }
                    .host-tools-panel .offcanvas-title { color: #f8fafc; font-size: 17px; }
                    .host-tools-panel .offcanvas-body { padding: 14px; scrollbar-width: thin; scrollbar-color: #334155 transparent; }
                    .tool-module {
                        padding: 14px;
                        margin-bottom: 12px;
                        border-radius: 14px;
                        background: #121b2e !important;
                        border: 1px solid rgba(148,163,184,.14) !important;
                        box-shadow: 0 10px 26px rgba(0,0,0,.1);
                        font-size: 12px;
                    }
                    .tool-module h6 { margin-bottom: 11px; color: #a9b7ca; font-size: 10px; letter-spacing: .08em; }
                    .tool-module .text-muted { color: #8292a8 !important; }
                    .tool-module .btn { min-height: 34px; border-radius: 9px !important; font-weight: 600; }
                    .tool-module .btn-xs { min-height: 30px; padding: 5px 8px !important; font-size: 11px !important; }
                    .tool-module .fw-bold { color: #eef2ff; }
                    .tool-module .badge { font-size: 9px; letter-spacing: .02em; }
                    .tool-module .rounded { background: #0d1526 !important; border: 1px solid rgba(148,163,184,.1); }
                    .form-dark { min-height: 38px; color: #eef2ff; background: #0a1120; border-color: rgba(148,163,184,.19); color-scheme: dark; }
                    .form-dark:focus { background: #0a1120; color: #fff; border-color: #7c5cff; box-shadow: 0 0 0 3px rgba(124,92,255,.12); }
                    .form-dark option { background: #111827; color: #f8fafc; }
                    #giftModal .modal-content, #topupModal .modal-content { background: #0f172a !important; border-color: rgba(148,163,184,.18) !important; box-shadow: 0 30px 80px rgba(0,0,0,.5); }
                    .gift-sticker-card { background: #151f34 !important; border-color: rgba(148,163,184,.16) !important; }
                    @media (max-width: 991.98px) {
                        .room-content > .row { height: auto !important; min-height: 100%; }
                        .stream-area { height: 62dvh !important; min-height: 440px; }
                        .chat-area { height: 38dvh !important; min-height: 300px; }
                        .stream-header-overlay { top: 12px; left: 12px; right: 12px; }
                        .stage-container { padding: 66px 12px 88px; }
                        .listeners-box { bottom: 82px; right: 12px; }
                    }
                    @media (max-width: 575.98px) {
                        .stream-header-overlay { gap: 8px; }
                        .host-badge { width: calc(56% - 4px); max-width: calc(56% - 4px); min-width: 0; }
                        .host-info { min-width: 0; }
                        .host-badge .d-flex { min-width: 0; }
                        .host-name { overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
                        .room-topic, .host-badge [style*="Followers"] { display: none; }
                        .live-stats { width: calc(44% - 4px); max-width: calc(44% - 4px); gap: 5px; }
                        .stat-pill { min-height: 28px; padding: 5px 8px; font-size: 10px; }
                        .host-avatar-big { width: 88px; height: 88px; font-size: 34px; }
                        .speaker-avatar { width: 64px; height: 64px; font-size: 23px; }
                        .listeners-box { display: none; }
                        .floating-action-bar { width: calc(100% - 24px); justify-content: center; }
                        .fab-btn { flex: 1; max-width: 68px; }
                        .host-tools-panel { --bs-offcanvas-width: 100vw; }
                    }
                    @media (prefers-reduced-motion: reduce) {
                        .host-avatar-big { animation: none; }
                        .fab-btn, .speaker-node-wrapper { transition: none; }
                    }
                </style>

                <div class="row g-0 w-100 h-100">

                    <!-- ========================================== -->
                    <!-- LEFT: THE STREAM (Immersive Stage)         -->
                    <!-- ========================================== -->
                    <div class="col-xl-9 col-lg-8 stream-area">

                        <!-- Stream Overlay Header -->
                        <div class="stream-header-overlay">
                            <div class="host-badge">
                                <div class="host-avatar-mini">
                                    ${room.hostUser != null ? room.hostUser.displayName.substring(0,1).toUpperCase() :
                                    'H'}
                                </div>
                                <div class="host-info">
                                    <div class="d-flex align-items-center gap-2">
                                        <span class="host-name">${room.hostUser != null ? room.hostUser.displayName : 'Unknown Host'}</span>
                                        <span style="font-size: 11px; color: #A29BFE; white-space: nowrap;">(<span id="followerCount">0</span> Followers)</span>
                                    </div>
                                    <span class="room-topic">${room.title}</span>
                                </div>
                                <c:if test="${room.hostUser != null && sessionScope.currentUser.id != room.hostUser.id}">
                                    <button id="btnFollow" class="btn btn-sm btn-outline-light ms-2"
                                        style="border-radius: 20px; font-size: 10px; padding: 2px 10px;">+ Follow</button>
                                </c:if>
                            </div>
                            <div class="live-stats">
                                <c:if test="${room.status == 'LIVE'}">
                                    <div class="stat-pill live">
                                        <div class="live-dot"
                                            style="width:6px;height:6px;background:#fff;border-radius:50%;animation:pulse-red 1s infinite;">
                                        </div> LIVE
                                    </div>
                                </c:if>
                                <c:if test="${room.levelNumber != null}">
                                    <div class="stat-pill" style="background: rgba(99,102,241,0.8); font-weight: 700;">
                                        <i class="bi bi-bar-chart-fill" style="font-size: 10px;"></i>
                                        Lvl ${room.levelNumber}
                                    </div>
                                </c:if>
                                <div class="stat-pill"><i class="bi bi-eye-fill"></i> <span id="eyeCount">${participants.size()}</span></div>
                                <div class="stat-pill" style="background: rgba(108,92,231,0.8);"><i
                                        class="bi bi-stars"></i> ${room.languageCode}</div>
                            </div>
                        </div>

                        <!-- The Stage (Network Graph) -->
                        <div class="stage-container" id="networkStage">
                            <svg id="network-lines-svg"></svg>
                            
                            <!-- Host -->
                            <div class="host-node-wrapper" id="hostNode">
                                <div class="d-flex flex-column align-items-center gap-2">
                                    <div class="host-avatar-big">
                                        ${room.hostUser != null ? room.hostUser.displayName.substring(0,1).toUpperCase() : 'H'}
                                        <div class="mic-icon-stage bg-danger" id="micIconStage_${room.hostUser.displayName}" style="width: 32px; height: 32px; font-size: 16px;">
                                            <i class="bi bi-mic-mute-fill" id="micIconStageInner_${room.hostUser.displayName}"></i>
                                        </div>
                                    </div>
                                    <div class="text-center">
                                        <div style="font-size: 16px; font-weight: 700; color: #fff; background: rgba(0,0,0,0.5); padding: 2px 8px; border-radius: 8px;">${room.hostUser != null ? room.hostUser.displayName : 'Host'}</div>
                                        <div style="font-size: 12px; color: #A29BFE; font-weight: 500;">Host</div>
                                    </div>
                                </div>
                            </div>

                            <!-- Speakers (dynamically rendered by JS) -->
                            <div id="speakersContainer"></div>

                            <!-- Listeners Box -->
                            <div class="listeners-box">
                                <h6>Listeners</h6>
                                <div class="listeners-grid" id="listenersContainer">
                                </div>
                            </div>
                        </div>

                        <!-- Floating Action Bar -->
                        <div class="floating-action-bar">
                            <!-- Toggle Mic Button -->
                            <button id="btnToggleMic" class="fab-btn" title="Mute/Unmute Mic" aria-label="Mute or unmute microphone" style="display:none;">
                                <i id="micIcon" class="bi bi-mic-fill"></i>
                                <span class="fab-label">Mic</span>
                            </button>

                            <!-- Send Gift triggers Modal -->
                            <button class="fab-btn primary" title="Send Gift" aria-label="Send a gift" data-bs-toggle="modal"
                                data-bs-target="#giftModal">
                                <i class="bi bi-gift-fill"></i>
                                <span class="fab-label">Gift</span>
                            </button>

                            <button id="btnRaiseHand" class="fab-btn" title="Request to Speak" aria-label="Raise hand to request speaking">
                                ✋
                            </button>

                            <!-- Host Tools -->
                            <button class="fab-btn" title="Host Tools" aria-label="Open host tools" data-bs-toggle="offcanvas"
                                data-bs-target="#hostToolsOffcanvas">
                                <i class="bi bi-sliders"></i>
                                <span class="fab-label">Tools</span>
                            </button>
                        </div>

                    </div>

                    <!-- ========================================== -->
                    <!-- RIGHT: LIVE CHAT & ACTIVITY STREAM         -->
                    <!-- ========================================== -->
                    <div class="col-xl-3 col-lg-4 chat-area">

                        <div class="console-header">
                            <div class="console-title"><i class="bi bi-chat-dots-fill me-1" style="color:#9f8cff"></i> Host Console</div>
                            <div class="console-subtitle">Live room activity and gifts</div>
                        </div>

                        <!-- Chat Stream -->
                        <div class="chat-messages" id="chatStream">
                            <div class="chat-msg system-alert">Welcome to ${room.title}! Remember to be polite and
                                respectful.</div>

                            <c:forEach var="txn" items="${giftTransactions}">
                                <div class="chat-msg gift-alert" style="display:flex;align-items:center;gap:8px">
                                    <c:choose><c:when test="${not empty txn.gift.imageUrl}"><img src="${txn.gift.imageUrl}" alt="${txn.gift.name}" style="width:38px;height:38px;object-fit:contain;flex:none" /></c:when><c:otherwise><i class="bi bi-gift-fill"></i></c:otherwise></c:choose>
                                    <span><span class="user">${txn.sender.displayName}</span> sent <strong>${txn.gift.name}</strong> to ${txn.receiver.displayName}</span>
                                </div>
                            </c:forEach>

                        </div>

                        <!-- Chat Input -->
                        <div class="chat-input-area">
                            <input type="text" id="chatInput" class="chat-input" placeholder="Say something nice...">
                            <button id="btnSendChat" class="btn-send" aria-label="Send chat message"><i class="bi bi-send-fill"></i></button>
                        </div>

                    </div>
                </div>

                <!-- ========================================== -->
                <!-- MODALS & OFFCANVAS (HOST TOOLS)            -->
                <!-- ========================================== -->

                <style>
                    .gift-sticker-grid{display:grid;grid-template-columns:repeat(3,minmax(0,1fr));gap:8px}.gift-sticker-option{position:relative;cursor:pointer}.gift-sticker-option input{position:absolute;opacity:0;pointer-events:none}.gift-sticker-card{min-height:112px;padding:8px 4px;border:2px solid rgba(255,255,255,.1);border-radius:14px;background:rgba(255,255,255,.04);display:flex;flex-direction:column;align-items:center;justify-content:center;gap:4px;text-align:center;color:#fff}.gift-sticker-card img{width:58px;height:58px;object-fit:contain}.gift-sticker-option input:checked+.gift-sticker-card{border-color:#FD79A8;background:rgba(253,121,168,.16);box-shadow:0 0 0 2px rgba(253,121,168,.12)}.gift-sticker-name{font-size:11px;font-weight:700}.gift-sticker-cost{font-size:10px;color:#cbd5e1}
                </style>
                <!-- Gift Modal -->
                <div class="modal fade" id="giftModal" tabindex="-1">
                    <div class="modal-dialog modal-dialog-centered modal-sm">
                        <div class="modal-content"
                            style="background: #1A1929; border: 1px solid rgba(255,255,255,0.1); border-radius: 20px;">
                            <div class="modal-header border-0 pb-0">
                                <h6 class="modal-title text-white fw-bold">Send Gift 🎁</h6>
                                <button type="button" class="btn-close btn-close-white"
                                    data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body">
                                <div class="text-center mb-3">
                                    <span class="badge" style="background: rgba(108,92,231,0.2); color: #A29BFE; font-size: 13px;">
                                        Your Balance: <span id="currentBalanceDisplay">${sessionScope.currentUser.creditBalance != null ? sessionScope.currentUser.creditBalance : 0}</span> cr
                                    </span>
                                </div>
                                <form method="post" action="/rooms/${room.id}/send-gift" id="formSendGift">
                                    <input type="hidden" name="senderId" value="${sessionScope.currentUser.id}">
                                    <input type="hidden" id="currentBalance" value="${sessionScope.currentUser.creditBalance != null ? sessionScope.currentUser.creditBalance : 0}">
                                    <div class="mb-3">
                                        <label class="form-label" style="font-size: 11px; color: #94A1B2;">To
                                            User</label>
                                        <select id="receiverSelect" name="receiverId" class="form-select form-select-sm form-dark" required>
                                            <c:forEach var="p" items="${participants}">
                                                <c:if test="${sessionScope.currentUser.id != p.user.id && (p.roleInRoom == 'SPEAKER' || p.roleInRoom == 'MODERATOR')}">
                                                    <option value="${p.user.id}">${p.displayName}</option>
                                                </c:if>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label" style="font-size: 11px; color: #94A1B2;">Select
                                            Gift</label>
                                        <div class="gift-sticker-grid">
                                            <c:forEach var="g" items="${gifts}" varStatus="giftStatus"><label class="gift-sticker-option"><input type="radio" name="giftId" value="${g.id}" data-cost="${g.creditCost}" <c:if test="${giftStatus.first}">checked</c:if> required /><span class="gift-sticker-card"><c:choose><c:when test="${not empty g.imageUrl}"><img src="${g.imageUrl}" alt="${g.name}" /></c:when><c:otherwise><i class="bi bi-gift-fill" style="font-size:32px"></i></c:otherwise></c:choose><span class="gift-sticker-name">${g.name}</span><span class="gift-sticker-cost"><fmt:formatNumber value="${g.creditCost}" pattern="#,##0"/> cr</span></span></label></c:forEach>
                                        </div>
                                    </div>
                                    <button type="submit" class="btn w-100"
                                        style="background: linear-gradient(135deg, #FD79A8, #E84393); color: white; border-radius: 12px; font-weight: 600;">
                                        Send 💖
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Top Up Iframe Modal -->
                <div class="modal fade" id="topupModal" tabindex="-1">
                    <div class="modal-dialog modal-dialog-centered modal-lg">
                        <div class="modal-content" style="background: #1A1929; border: 1px solid rgba(255,255,255,0.1); border-radius: 20px;">
                            <div class="modal-header border-0 pb-0">
                                <h6 class="modal-title text-white fw-bold">Top Up Credits 💳</h6>
                                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body p-0" style="height: 60vh;">
                                <iframe src="/billing/topup" style="width: 100%; height: 100%; border: none; border-radius: 0 0 20px 20px;"></iframe>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Host Tools Offcanvas -->
                <div class="offcanvas offcanvas-end host-tools-panel" tabindex="-1" id="hostToolsOffcanvas">
                    <div class="offcanvas-header">
                        <h5 class="offcanvas-title fw-bold"><i class="bi bi-sliders me-1"
                                style="color: #00CEC9;"></i> Host Tools</h5>
                        <button type="button" class="btn-close btn-close-white"
                            data-bs-dismiss="offcanvas"></button>
                    </div>
                    <div class="offcanvas-body">

                        <!-- Room Control -->
                        <div class="tool-module">
                            <h6>Room Controls</h6>
                            <div class="d-flex flex-column gap-2">
                                <a href="/rooms/${room.id}/end" class="btn w-100 btn-sm"
                                    style="background: rgba(239,68,68,0.2); color: #FCA5A5; border: 1px solid #EF4444; border-radius: 8px;"
                                    >
                                    <i class="bi bi-stop-fill me-1"></i> End Live Stream
                                </a>
                                <a href="/rooms/${room.id}/next-stage" class="btn w-100 btn-sm btn-outline-info" style="border-radius: 8px;">
                                    <i class="bi bi-arrow-right-circle me-1"></i> Next Chapter/Stage
                                </a>
                                <a href="/rooms/${room.id}/toggle-recording" class="btn w-100 btn-sm ${room.isRecording ? 'btn-danger' : 'btn-outline-danger'}" style="border-radius: 8px;">
                                    <i class="bi ${room.isRecording ? 'bi-record-fill' : 'bi-record'} me-1"></i>
                                    ${room.isRecording ? 'Stop Recording' : 'Start Recording'}
                                </a>
                                <a href="/rooms/${room.id}/export-participants" class="btn w-100 btn-sm btn-outline-success" style="border-radius: 8px;">
                                    <i class="bi bi-file-earmark-excel me-1"></i> Export Participants
                                </a>
                            </div>
                        </div>

                        <!-- AI Support -->
                        <div class="tool-module" style="background: rgba(108, 92, 231, 0.1); border: 1px solid rgba(108, 92, 231, 0.2);">
                            <h6 style="color: #A29BFE;"><i class="bi bi-robot me-1"></i> AI Moderator Support</h6>
                            <p class="text-muted" style="font-size: 11px; margin-bottom: 8px;">Suggest discussion topics from the current lesson</p>
                            <div class="d-flex flex-column gap-2">
                                <select id="aiPromptType" class="form-select form-select-sm form-dark">
                                    <option value="discussion_topic">Discussion Topics</option>
                                    <option value="warmup">Warm-up Questions</option>
                                    <option value="discussion">Discussion Questions</option>
                                    <option value="practice">Practice Exercises</option>
                                    <option value="wrapup">Wrap-up Questions</option>
                                </select>
                                <c:set var="aiLessonId" value="${room.currentLesson != null ? room.currentLesson.id : 0}" />
                                <button type="button" class="btn btn-sm w-100" style="background: #6C5CE7; color: white; border-radius: 8px;" onclick="generateAiSuggestions(Number('${aiLessonId}'))">
                                    <i class="bi bi-magic me-1"></i> AI Suggest
                                </button>
                                <div id="aiLoadingIndicator" style="display: none; text-align: center; margin-top: 8px;">
                                    <div class="spinner-border spinner-border-sm text-primary" role="status"></div>
                                    <span style="font-size: 12px; color: #A29BFE;"> Generating...</span>
                                </div>
                                <div id="aiResultContainer" class="mt-2 d-flex flex-column gap-2"></div>
                            </div>
                        </div>

                        <!-- Pending Join Requests (Real-time update panel) -->
                        <div class="tool-module" style="background: rgba(245, 158, 11, 0.1); border: 1px solid rgba(245, 158, 11, 0.2);">
                            <h6 style="color: #F59E0B;"><i class="bi bi-person-plus-fill me-1"></i> Join Requests</h6>
                            <div id="pendingRequestsList" class="d-flex flex-column gap-2 mt-2">
                                <c:choose>
                                    <c:when test="${empty pendingRequests}">
                                        <div class="text-muted" style="font-size: 11px;">No pending requests</div>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="req" items="${pendingRequests}">
                                            <div class="d-flex justify-content-between align-items-center p-2 rounded" style="background: rgba(0,0,0,0.2); font-size: 12px;">
                                                <div>
                                                    <div class="fw-bold">${req.displayName}</div>
                                                    <div class="text-muted" style="font-size: 10px;">wants to be a ${req.roleRequested}</div>
                                                </div>
                                                <div class="d-flex gap-1">
                                                    <button type="button" class="btn btn-xs btn-success py-1 px-2" style="font-size: 10px; border-radius: 4px;" onclick="approveJoinRequest(this)" data-id="${req.id}" data-name="${req.displayName}">Approve</button>
                                                    <button type="button" class="btn btn-xs btn-danger py-1 px-2" style="font-size: 10px; border-radius: 4px;" onclick="denyJoinRequest(this)" data-id="${req.id}" data-name="${req.displayName}">Deny</button>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <div class="tool-module">
                            <h6>Current Participants</h6>
                            <div class="d-flex flex-column gap-2" id="sidebarParticipantsContainer" style="max-height: 250px; overflow-y: auto;">
                                <!-- Rendered dynamically by refreshParticipantsUI() -->
                                <c:forEach var="p" items="${participants}">
                                    <div class="d-flex justify-content-between align-items-center p-2 rounded" style="background: rgba(0,0,0,0.2); font-size: 12px;">
                                        <div class="text-truncate me-2">
                                            <div class="fw-bold text-truncate">${p.displayName}</div>
                                            <div class="text-muted" style="font-size: 10px;">
                                                Role: <span class="badge ${p.roleInRoom == 'SPEAKER' ? 'bg-primary' : (p.roleInRoom == 'MODERATOR' ? 'bg-warning' : 'bg-secondary')}">${p.roleInRoom}</span>
                                            </div>
                                        </div>
                                        <div class="d-flex gap-1 flex-shrink-0">
                                            <c:choose>
                                                <c:when test="${room.hostUser != null && p.user.id == room.hostUser.id}">
                                                    <span class="text-warning" style="font-size: 10px; font-weight: bold;">👑 Host</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="/rooms/${room.id}/toggle-role/${p.id}" class="btn btn-xs btn-outline-info py-0 px-2 flex-shrink-0" style="font-size: 9px; border-radius: 4px;" title="Promote or Demote">Role</a>
                                                    <button type="button" id="staticMicBtn_${p.id}" onclick="setMicPermission('${p.id}')" class="btn btn-xs ${p.micAllowed ? 'btn-warning' : 'btn-outline-success'} py-0 px-2 flex-shrink-0" style="font-size:9px;border-radius:4px" title="${p.micAllowed ? 'Revoke microphone' : 'Allow microphone'}"><i id="staticMicIcon_${p.id}" class="bi ${p.micAllowed ? 'bi-mic-mute' : 'bi-mic'}"></i></button>
                                                    <button type="button" class="btn btn-xs btn-danger py-0 px-2 flex-shrink-0" style="font-size:9px;border-radius:4px" onclick="kickSpeaker('${p.id}', '${p.displayName}')" title="Kick user">Kick</button>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>

                        <!-- Pin Material -->
                        <div class="tool-module">
                            <h6>
                                <i class="bi bi-pin-angle me-1"></i> Pin Material to Stream
                                <c:if test="${room.levelNumber != null}">
                                    <span class="badge" style="background: rgba(99,102,241,0.3); color: #A5B4FC; font-size: 9px; margin-left: 4px;">Level ${room.levelNumber} topics</span>
                                </c:if>
                            </h6>
                            <c:if test="${room.currentLesson != null}">
                                <div class="mb-2 p-2 rounded" style="background: rgba(99,102,241,0.1); border: 1px solid rgba(99,102,241,0.2); font-size: 11px;">
                                    <div style="color: #A5B4FC; font-weight: 700;">Current Topic:</div>
                                    <div style="color: #E0E7FF;">${room.currentLesson.title}</div>
                                    <div style="color: #64748B; font-size: 10px; margin-top: 2px;"><i class="bi bi-robot me-1"></i>AI auto-transitions every 10 min</div>
                                </div>
                            </c:if>
                            <form method="post" action="/rooms/${room.id}/pin-material"
                                class="d-flex flex-column gap-2">
                                <select name="lessonId" class="form-select form-select-sm form-dark" required>
                                    <option value="">— Select Lesson —</option>
                                    <c:forEach var="l" items="${lessons}">
                                        <option value="${l.id}" ${room.currentLesson != null && room.currentLesson.id == l.id ? 'selected' : ''}>
                                            <c:if test="${l.levelNumber != null}">[Lvl ${l.levelNumber}]</c:if>
                                            [${l.type}] ${l.title}
                                        </option>
                                    </c:forEach>
                                </select>
                                <button type="submit" class="btn btn-sm"
                                    style="background: rgba(255,255,255,0.1); color: white; border-radius: 8px;">Pin</button>
                            </form>
                            <c:if test="${not empty pinnedMaterials}">
                                <div class="mt-2">
                                    <div style="font-size: 10px; color: #94A1B2; margin-bottom: 4px;">Active Pins:</div>
                                    <c:forEach var="pm" items="${pinnedMaterials}">
                                        <div class="d-flex justify-content-between align-items-center p-1 mb-1 rounded" style="background: rgba(0,0,0,0.2); font-size: 11px;">
                                            <span style="color: #E0E7FF;"><i class="bi bi-pin-fill me-1" style="color: #6366F1;"></i>${pm.title}</span>
                                            <a href="/rooms/${room.id}/unpin/${pm.id}" class="text-danger" style="font-size: 10px;" title="Unpin"><i class="bi bi-x-circle"></i></a>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:if>
                        </div>

                    </div>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/stompjs@2.3.3/lib/stomp.min.js"></script>
                <script>
                    var roomId = '${room.id}';
                    var currentUser = '${room.hostUser != null ? room.hostUser.displayName : "Host"}';
                    
                    var socket = new SockJS('/ws');
                    var stompClient = Stomp.over(socket);
                    stompClient.debug = null; // Tắt log nhảm của STOMP

                    stompClient.connect({}, function (frame) {
                        stompClient.subscribe('/topic/room/' + roomId, function (message) {
                            var msg = JSON.parse(message.body);
                            
                            var chatStream = document.getElementById('chatStream');

                            // Xử lý Chat
                            if (msg.type === 'CHAT') {
                                var div = document.createElement('div');
                                div.className = 'chat-msg';
                                div.innerHTML = '<span class="user">' + msg.senderName + ':</span> ' + msg.content;
                                chatStream.appendChild(div);
                                chatStream.scrollTop = chatStream.scrollHeight;
                            } 
                            else if (msg.type === 'RAISE_HAND') {
                                refreshParticipantsUI();
                                var div = document.createElement('div');
                                if (msg.content === 'OFF') {
                                    div.className = 'chat-msg system-alert';
                                    div.style = 'opacity: 0.6; color: #CBD5E1;';
                                    div.innerHTML = '✋ <b>' + msg.senderName + '</b> lowered their hand.';
                                } else {
                                    div.className = 'chat-msg system-alert';
                                    div.innerHTML = '✋ <b>' + msg.senderName + '</b> wants to speak!';
                                }
                                chatStream.appendChild(div);
                                chatStream.scrollTop = chatStream.scrollHeight;
                            }
                            // Xử lý Follow
                            else if (msg.type === 'FOLLOW') {
                                var div = document.createElement('div');
                                div.className = 'chat-msg gift-alert';
                                div.innerHTML = '💖 <b>' + msg.senderName + '</b> followed the host!';
                                chatStream.appendChild(div);
                                chatStream.scrollTop = chatStream.scrollHeight;
                                
                                var fc = document.getElementById('followerCount');
                                if (fc) {
                                    fc.innerText = parseInt(fc.innerText) + 1;
                                }
                            }
                            // Xử lý bật/tắt Mic
                            else if (msg.type === 'MIC_TOGGLE') {
                                refreshParticipantsUI();
                                var micStage = document.getElementById('micIconStage_' + msg.senderName);
                                var micInner = document.getElementById('micIconStageInner_' + msg.senderName);
                                if (micStage && micInner) {
                                    if (msg.content === 'ON') {
                                        micInner.className = 'bi bi-mic-fill';
                                        micStage.classList.remove('bg-danger');
                                    } else {
                                        micInner.className = 'bi bi-mic-mute-fill';
                                        micStage.classList.add('bg-danger');
                                    }
                                }
                            }
                            else if (msg.type === 'MIC_PERMISSION') {
                                refreshParticipantsUI();
                            }
                            // Bị Host ép tắt Mic
                            else if (msg.type === 'FORCE_MUTE' && currentUser === msg.receiverName) {
                                if (!isMuted) {
                                    isMuted = true;
                                    if (rtc.localAudioTrack) {
                                        rtc.localAudioTrack.setEnabled(false);
                                    }
                                    if (btnToggleMic) {
                                        btnToggleMic.style.background = 'rgba(239, 68, 68, 0.2)';
                                        btnToggleMic.style.color = '#EF4444';
                                    }
                                    if (micIcon) {
                                        micIcon.className = 'bi bi-mic-mute-fill';
                                    }
                                    stompClient.send('/app/room/' + roomId, {}, JSON.stringify({ type: 'MIC_TOGGLE', senderName: currentUser, content: 'OFF' }));
                                    var participantId = '${currentParticipant != null ? currentParticipant.id : ""}';
                                    if (participantId) {
                                        fetch('/api/rooms/' + roomId + '/toggle-mic/' + participantId, { method: 'POST', credentials: 'same-origin' });
                                    }
                                    Swal.fire({
                                        icon: 'warning',
                                        title: 'Muted by Host',
                                        text: 'The host has muted your microphone.',
                                        toast: true,
                                        position: 'top-end',
                                        showConfirmButton: false,
                                        timer: 3000
                                    });
                                }
                            }
                            // Xử lý khi có người được chấp nhận vào phòng, người mới vào, ra, hoặc bị kick
                            else if (msg.type === 'JOIN_APPROVED' || msg.type === 'PARTICIPANT_KICKED' || msg.type === 'JOIN' || msg.type === 'LEAVE') {
                                refreshParticipantsUI();
                            }
                            // Nhận tín hiệu có yêu cầu tham gia mới
                            else if (msg.type === 'JOIN_REQUEST') {
                                // Phát âm thanh thông báo
                                var audio = new Audio('https://assets.mixkit.co/active_storage/sfx/2869/2869-preview.mp3');
                                audio.play().catch(function(e){ console.log("Audio play prevented", e); });
                                
                                // Hiện Popup
                                Swal.fire({
                                    toast: true,
                                    position: 'top-end',
                                    icon: 'info',
                                    title: 'New Join Request!',
                                    text: msg.senderName + ' wants to join the stage.',
                                    timer: 5000,
                                    showConfirmButton: false,
                                    background: '#1E1B4B',
                                    color: '#fff'
                                });
                                
                                if (typeof pollPendingRequests === 'function') {
                                    pollPendingRequests();
                                }
                            }
                            // Xử lý Quà tặng
                            else if (msg.type === 'GIFT') {
                                var isReceiver = ('${sessionScope.currentUser.id}' === String(msg.receiverId));
                                var isHost = ('${room.hostUser.id}' === String(msg.receiverId));
                                
                                if (isReceiver) {
                                    Swal.fire({
                                        icon: 'success',
                                        title: 'You got a gift! 🎁',
                                        text: msg.senderName + ' sent you a ' + msg.content + '!',
                                        background: '#1E1B4B', color: '#fff',
                                        toast: true, position: 'top-end', showConfirmButton: false, timer: 4000
                                    });
                                }
                                
                                // Nếu host là người nhận thì ai trong phòng cũng thấy trên chat
                                if (isHost) {
                                    var div = document.createElement('div');
                                    div.className = 'chat-msg gift-alert';
                                    div.innerHTML = '<span class="user">' + msg.senderName + '</span> sent <strong>' + msg.content + '</strong> to the host!';
                                    chatStream.appendChild(div);
                                    chatStream.scrollTop = chatStream.scrollHeight;
                                }
                            }
                        });

                        // Báo cho toàn server biết mình đã Join để tăng mắt xem
                        stompClient.send('/app/room/' + roomId, {}, JSON.stringify({ type: 'JOIN', senderName: currentUser }));
                        
                        const urlParams = new URLSearchParams(window.location.search);
                        if (urlParams.get('success') === 'gift_sent') {
                            var encName = urlParams.get('giftName');
                            var encIcon = urlParams.get('giftIcon');
                            var rId = urlParams.get('receiverId');
                            var balance = urlParams.get('balance');
                            var giftContent = decodeURIComponent(encIcon) + ' ' + decodeURIComponent(encName);
                            
                            stompClient.send('/app/room/' + roomId, {}, JSON.stringify({
                                type: 'GIFT',
                                senderName: currentUser,
                                content: giftContent,
                                receiverId: parseInt(rId)
                            }));
                            
                            Swal.fire({
                                icon: 'success',
                                title: 'Gift Sent!',
                                text: 'Your remaining balance is: ' + balance + ' cr',
                                background: '#1E1B4B', color: '#fff', confirmButtonColor: '#6C5CE7',
                                toast: true, position: 'top-end', showConfirmButton: false, timer: 4000
                            });
                            
                            window.history.replaceState({}, document.title, window.location.pathname);
                        }
                    });

                    // Gift Form Intercept
                    var formSendGift = document.getElementById('formSendGift');
                    if (formSendGift) {
                        formSendGift.addEventListener('submit', function(e) {
                            var currentBalance = parseFloat(document.getElementById('currentBalance').value);
                            var selectedGift = document.querySelector('#formSendGift input[name="giftId"]:checked');
                            var cost = selectedGift ? parseFloat(selectedGift.getAttribute('data-cost')) : 0;
                            
                            if (currentBalance < cost) {
                                e.preventDefault();
                                
                                var giftModalEl = document.getElementById('giftModal');
                                var giftModal = bootstrap.Modal.getInstance(giftModalEl);
                                if (giftModal) giftModal.hide();
                                
                                Swal.fire({
                                    icon: 'warning',
                                    title: 'Insufficient Credits',
                                    text: 'You do not have enough credits for this gift. Would you like to top up?',
                                    showCancelButton: true,
                                    confirmButtonText: 'Yes, Top Up',
                                    cancelButtonText: 'Cancel',
                                    background: '#1E1B4B', color: '#fff', confirmButtonColor: '#6C5CE7', cancelButtonColor: '#EF4444'
                                }).then((result) => {
                                    if (result.isConfirmed) {
                                        var topupModal = new bootstrap.Modal(document.getElementById('topupModal'));
                                        topupModal.show();
                                    }
                                });
                            } else {
                                e.preventDefault();
                                var formData = new FormData(formSendGift);
                                fetch('/api/rooms/' + roomId + '/send-gift', {
                                    method: 'POST',
                                    body: new URLSearchParams(formData)
                                })
                                .then(response => {
                                    if(response.ok) return response.json();
                                    throw new Error("Failed to send gift");
                                })
                                .then(data => {
                                    var giftModalEl = document.getElementById('giftModal');
                                    var giftModal = bootstrap.Modal.getInstance(giftModalEl);
                                    if (giftModal) giftModal.hide();
                                    
                                    var currentBalanceEl = document.getElementById('currentBalanceDisplay');
                                    if(currentBalanceEl) currentBalanceEl.innerText = data.senderCreditBalance;
                                    var currentBalanceInput = document.getElementById('currentBalance');
                                    if(currentBalanceInput) currentBalanceInput.value = data.senderCreditBalance;

                                    Swal.fire({
                                        icon: 'success',
                                        title: 'Gift Sent!',
                                        text: 'Your remaining balance is: ' + data.senderCreditBalance + ' cr',
                                        background: '#1E1B4B', color: '#fff', confirmButtonColor: '#6C5CE7',
                                        toast: true, position: 'top-end', showConfirmButton: false, timer: 4000
                                    });

                                    // Send WS message
                                    var icon = selectedGift.closest('.card-body').querySelector('h5').innerText || '🎁';
                                    stompClient.send('/app/room/' + roomId, {}, JSON.stringify({ type: 'GIFT', senderName: currentUser, content: icon }));
                                })
                                .catch(error => {
                                    console.error('Error:', error);
                                    Swal.fire({
                                        icon: 'error',
                                        title: 'Oops...',
                                        text: 'Something went wrong while sending the gift!',
                                        background: '#1E1B4B', color: '#fff', confirmButtonColor: '#6C5CE7'
                                    });
                                });
                            }
                        });
                    }

                    // Gửi Chat
                    document.getElementById('btnSendChat').onclick = function() {
                        var input = document.getElementById('chatInput');
                        if (input.value.trim() !== '') {
                            stompClient.send('/app/room/' + roomId, {}, JSON.stringify({ type: 'CHAT', senderName: currentUser, content: input.value }));
                            input.value = '';
                        }
                    };
                    document.getElementById('chatInput').addEventListener('keypress', function (e) {
                        if (e.key === 'Enter') document.getElementById('btnSendChat').click();
                    });

                    // Giơ tay
                    let isHandRaised = false;
                    document.getElementById('btnRaiseHand').onclick = function() {
                        isHandRaised = !isHandRaised;
                        stompClient.send('/app/room/' + roomId, {}, JSON.stringify({ type: 'RAISE_HAND', senderName: currentUser, content: isHandRaised ? 'ON' : 'OFF' }));
                        
                        // Update UI
                        if (isHandRaised) {
                            this.style.background = '#F59E0B'; // Đổi màu thành vàng báo hiệu đang giơ tay
                            this.style.color = '#fff';
                        } else {
                            this.style.background = ''; // Trở về bình thường
                            this.style.color = '';
                        }
                    };

                    // Load follower count on page load (cho cả Host lẫn Learner)
                    fetch('/api/users/${room.hostUser.id}/follow-status')
                        .then(res => res.json())
                        .then(data => {
                            document.getElementById('followerCount').innerText = data.followerCount;
                        });

                    // Follow (chỉ hiện cho người không phải host)
                    var btnFollow = document.getElementById('btnFollow');
                    if (btnFollow) {
                        fetch('/api/users/${room.hostUser.id}/follow-status')
                            .then(res => res.json())
                            .then(data => {
                                if (data.isFollowing) {
                                    btnFollow.innerHTML = 'Following';
                                    btnFollow.className = 'btn btn-sm btn-light ms-2';
                                }
                            });

                        btnFollow.onclick = function() {
                            fetch('/api/users/${room.hostUser.id}/toggle-follow', { method: 'POST' })
                                .then(res => res.json())
                                .then(data => {
                                    document.getElementById('followerCount').innerText = data.followerCount;
                                    if (data.isFollowing) {
                                        this.innerHTML = 'Following';
                                        this.className = 'btn btn-sm btn-light ms-2';
                                        stompClient.send('/app/room/' + roomId, {}, JSON.stringify({ type: 'FOLLOW', senderName: currentUser }));
                                    } else {
                                        this.innerHTML = '+ Follow';
                                        this.className = 'btn btn-sm btn-outline-light ms-2';
                                    }
                                });
                        };
                    }

                    // Do not announce a leave during reloads or in-room navigation.
                    // The room lifecycle actions handle the host's real departure.
                    window.addEventListener('beforeunload', function() {
                        if (stompClient !== null) {
                            stompClient.disconnect();
                        }
                    });

                    // Phê duyệt yêu cầu tham gia qua REST API + WebSocket để phản hồi tức thì
                    function approveJoinRequest(btn) {
                        var requestId = btn.getAttribute('data-id');
                        var displayName = btn.getAttribute('data-name');
                        fetch('/api/rooms/' + roomId + '/approve-join/' + requestId, { method: 'POST' })
                            .then(res => res.json())
                            .then(data => {
                                stompClient.send('/app/room/' + roomId, {}, JSON.stringify({
                                    type: 'JOIN_APPROVED',
                                    senderName: displayName,
                                    content: 'APPROVED'
                                }));
                                pollPendingRequests();
                                refreshParticipantsUI();
                            })
                            .catch(err => console.error("Error approving join request:", err));
                    }

                    function denyJoinRequest(btn) {
                        var requestId = btn.getAttribute('data-id');
                        var displayName = btn.getAttribute('data-name');
                        fetch('/api/rooms/' + roomId + '/deny-join/' + requestId, { method: 'POST' })
                            .then(res => res.json())
                            .then(data => {
                                stompClient.send('/app/room/' + roomId, {}, JSON.stringify({
                                    type: 'JOIN_DENIED',
                                    senderName: displayName,
                                    content: 'DENIED'
                                }));
                                pollPendingRequests();
                            })
                            .catch(err => console.error("Error denying join request:", err));
                    }

                    function pollPendingRequests() {
                        fetch('/api/rooms/' + roomId + '/pending-requests')
                            .then(response => response.json())
                            .then(data => {
                                const listContainer = document.getElementById('pendingRequestsList');
                                if (!listContainer) return;
                                if (data.length === 0) {
                                    listContainer.innerHTML = '<div class="text-muted" style="font-size: 11px;">No pending requests</div>';
                                    return;
                                }
                                let html = '';
                                data.forEach(req => {
                                    html += '<div class="d-flex justify-content-between align-items-center p-2 rounded" style="background: rgba(0,0,0,0.2); font-size: 12px;">' +
                                                '<div>' +
                                                    '<div class="fw-bold">' + req.displayName + '</div>' +
                                                    '<div class="text-muted" style="font-size: 10px;">wants to be a ' + req.roleRequested + '</div>' +
                                                '</div>' +
                                                '<div class="d-flex gap-1">' +
                                                    '<button type="button" class="btn btn-xs btn-success py-1 px-2" style="font-size: 10px; border-radius: 4px;" onclick="approveJoinRequest(this)" data-id="' + req.requestId + '" data-name="' + req.displayName + '">Approve</button>' +
                                                    '<button type="button" class="btn btn-xs btn-danger py-1 px-2" style="font-size: 10px; border-radius: 4px;" onclick="denyJoinRequest(this)" data-id="' + req.requestId + '" data-name="' + req.displayName + '">Deny</button>' +
                                                '</div>' +
                                            '</div>';
                                });
                                listContainer.innerHTML = html;
                            })
                            .catch(err => console.error("Error polling join requests:", err));
                    }
                    setInterval(pollPendingRequests, 10000);

                    // AI Suggest topics/questions
                    function generateAiSuggestions(lessonId) {
                        if (!lessonId || lessonId === 0) {
                            Swal.fire({
                                icon: 'warning',
                                title: 'No Lesson Selected',
                                text: 'No lesson currently selected in the room.',
                                background: '#1E1B4B', color: '#fff', confirmButtonColor: '#6C5CE7'
                            });
                            return;
                        }
                        var promptType = document.getElementById('aiPromptType').value;
                        var btnContainer = document.getElementById('aiResultContainer');
                        var loading = document.getElementById('aiLoadingIndicator');
                        
                        btnContainer.innerHTML = '';
                        loading.style.display = 'block';

                        var url = promptType === 'discussion_topic'
                            ? '/api/ai/suggest-topics?lessonId=' + lessonId
                            : '/api/ai/suggest-questions?lessonId=' + lessonId + '&promptType=' + encodeURIComponent(promptType);

                        fetch(url, { method: 'POST' })
                            .then(res => res.json())
                            .then(data => {
                                loading.style.display = 'none';
                                if (data.message) {
                                    btnContainer.innerHTML = '<div class="text-danger" style="font-size: 12px;">' + data.message + '</div>';
                                    return;
                                }
                                if (data.questions && data.questions.length > 0) {
                                    btnContainer.innerHTML = '';
                                    data.questions.forEach(q => {
                                        var text = q.generatedQuestion || q;
                                        var item = document.createElement('div');
                                        item.className = 'p-2 rounded mb-1';
                                        item.style.cssText = 'background: rgba(255,255,255,0.05); font-size: 12px;';
                                        item.innerHTML = '<div class="d-flex justify-content-between align-items-start"><div class="flex-grow-1"></div><button class="btn btn-xs btn-outline-light ms-2 py-0 px-1" onclick="sendAiQuestionToChat(this)"><i class="bi bi-send"></i></button></div>';
                                        item.querySelector('.flex-grow-1').textContent = text;
                                        item.querySelector('button').setAttribute('data-q', encodeURIComponent(text));
                                        btnContainer.appendChild(item);
                                    });
                                } else {
                                    btnContainer.innerHTML = '<div class="text-muted" style="font-size: 12px;">No questions generated.</div>';
                                }
                            })
                            .catch(err => {
                                loading.style.display = 'none';
                                btnContainer.innerHTML = '<div class="text-danger" style="font-size: 12px;">Error generating questions.</div>';
                                console.error(err);
                            });
                    }

                    function sendAiQuestionToChat(btn) {
                        var question = decodeURIComponent(btn.getAttribute('data-q'));
                        if (question && stompClient) {
                            var formattedMsg = '🤖 [AI Moderator]: ' + question;
                            stompClient.send('/app/room/' + roomId, {}, JSON.stringify({ type: 'CHAT', senderName: currentUser, content: formattedMsg }));
                            
                            // Flash button to show success
                            var origHTML = btn.innerHTML;
                            btn.innerHTML = '<i class="bi bi-check2"></i>';
                            btn.classList.add('btn-success');
                            btn.classList.remove('btn-outline-light');
                            setTimeout(() => {
                                btn.innerHTML = origHTML;
                                btn.classList.remove('btn-success');
                                btn.classList.add('btn-outline-light');
                            }, 2000);
                        }
                    }
                </script>

                <script src="https://download.agora.io/sdk/release/AgoraRTC_N-4.20.0.js"></script>
                <script>
                    // Auto-scroll chat to bottom
                    var chatStream = document.getElementById('chatStream');
                    if (chatStream) chatStream.scrollTop = chatStream.scrollHeight;

                    // Agora Mock Logic
                    var rtc = { client: null, localAudioTrack: null };
                    var options = { appId: "1adc56609faa4f95b208d10e17d60786", channel: "lucy_room_${room.id}", uid: Math.floor(Math.random() * 10000), token: null };

                    var isMuted = false;
                    var btnToggleMic = document.getElementById('btnToggleMic');
                    var micIcon = document.getElementById('micIcon');

                    btnToggleMic.onclick = async function () {
                        if (!rtc.localAudioTrack) return;
                        try {
                            if (isMuted) {
                                await rtc.localAudioTrack.setEnabled(true);
                                isMuted = false;
                                micIcon.className = 'bi bi-mic-fill';
                                btnToggleMic.style.background = '';
                                btnToggleMic.style.color = '';
                            } else {
                                await rtc.localAudioTrack.setEnabled(false);
                                isMuted = true;
                                micIcon.className = 'bi bi-mic-mute-fill';
                                btnToggleMic.style.background = 'rgba(239, 68, 68, 0.2)';
                                btnToggleMic.style.color = '#EF4444';
                            }
                            stompClient.send('/app/room/' + roomId, {}, JSON.stringify({ type: 'MIC_TOGGLE', senderName: currentUser, content: isMuted ? 'OFF' : 'ON' }));
                        } catch (err) {
                            console.error("Failed to toggle mic:", err);
                        }
                    };

                    async function joinChannel() {
                        try {
                            const response = await fetch('/api/agora/token?channelName=' + options.channel + '&uid=' + options.uid + '&role=publisher');
                            const data = await response.json();
                            options.token = (data.token && data.token.startsWith('006MOCK')) ? null : data.token;

                            rtc.client = AgoraRTC.createClient({ mode: "rtc", codec: "vp8" });
                            rtc.client.on("user-published", async function (user, mediaType) {
                                await rtc.client.subscribe(user, mediaType);
                                if (mediaType === "audio") user.audioTrack.play();
                            });

                            await rtc.client.join(options.appId, options.channel, options.token, options.uid);
                            rtc.localAudioTrack = await AgoraRTC.createMicrophoneAudioTrack({
                                AEC: true,
                                ANS: true,
                                AGC: true
                            });
                            await rtc.client.publish([rtc.localAudioTrack]);
                            
                            // Tắt mic mặc định khi vừa vào
                            await rtc.localAudioTrack.setEnabled(false);
                            isMuted = true;
                            if (micIcon) micIcon.className = 'bi bi-mic-mute-fill';
                            if (btnToggleMic) {
                                btnToggleMic.style.display = 'flex';
                                btnToggleMic.style.background = 'rgba(239, 68, 68, 0.2)';
                                btnToggleMic.style.color = '#EF4444';
                            }
                            stompClient.send('/app/room/' + roomId, {}, JSON.stringify({ type: 'MIC_TOGGLE', senderName: currentUser, content: 'OFF' }));
                        } catch (error) {
                            console.error("Auto-connect audio failed (browser autoplay blocked or mic permission denied):", error);
                            // We can show a toast here if we want to alert the user
                        }
                    }

                    // ── Dynamic Participants Rendering ──
                    function refreshParticipantsUI() {
                        fetch('/api/rooms/' + roomId)
                            .then(res => res.json())
                            .then(data => {
                                const participants = data.participants || [];
                                const speakersContainer = document.getElementById('speakersContainer');
                                const listenersContainer = document.getElementById('listenersContainer');
                                
                                // ── Render Speakers ──
                                let speakersHtml = '';
                                participants.forEach(p => {
                                    if (p.roleInRoom === 'SPEAKER' || p.roleInRoom === 'MODERATOR') {
                                        const initial = p.displayName.charAt(0).toUpperCase();
                                        const micClass = p.micOn ? '' : 'bg-danger';
                                        const micIcon = p.micOn ? 'bi-mic-fill' : 'bi-mic-mute-fill';
                                        const handBorder = p.handRaised ? 'border: 3px solid #F59E0B;' : '';
                                        speakersHtml += '<div class="speaker-node-wrapper speaker-node">' +
                                            '<div class="d-flex flex-column align-items-center gap-1">' +
                                                '<div class="speaker-avatar" style="' + handBorder + '">' +
                                                    initial +
                                                    '<div class="mic-icon-stage ' + micClass + '" id="micIconStage_' + p.displayName + '">' +
                                                        '<i class="bi ' + micIcon + '" id="micIconStageInner_' + p.displayName + '"></i>' +
                                                    '</div>' +
                                                '</div>' +
                                                '<div style="font-size: 11px; color: #E2E8F0; background: rgba(0,0,0,0.5); padding: 2px 6px; border-radius: 4px;">' + p.displayName + '</div>' +
                                                '<div class="mt-1 d-flex gap-1" style="position: absolute; bottom: -25px; white-space: nowrap;">' +
                                                    '<button class="badge ' + (p.micAllowed ? 'bg-warning text-dark' : 'bg-success') + ' border-0" title="' + (p.micAllowed ? 'Revoke microphone' : 'Allow microphone') + '" onclick="setMicPermission(' + p.id + ')"><i class="bi ' + (p.micAllowed ? 'bi-mic-mute-fill' : 'bi-mic-fill') + '"></i></button>' +
                                                    '<button class="badge bg-danger border-0" title="Remove User" onclick="kickSpeaker(' + p.id + ', \'' + p.displayName.replace(/'/g, "\\'") + '\')"><i class="bi bi-x-circle"></i></button>' +
                                                '</div>' +
                                            '</div>' +
                                        '</div>';
                                    }
                                });
                                if (speakersContainer) speakersContainer.innerHTML = speakersHtml;

                                // ── Render Listeners ──
                                let listenersHtml = '';
                                participants.forEach(p => {
                                    if (p.roleInRoom === 'LISTENER') {
                                        const initial = p.displayName.charAt(0).toUpperCase();
                                        listenersHtml += '<div class="listener-item" title="' + p.displayName + '">' +
                                            '<div class="listener-avatar">' + initial + '</div>' +
                                            '<div class="listener-name">' + p.displayName + '</div>' +
                                        '</div>';
                                    }
                                });
                                if (listenersContainer) listenersContainer.innerHTML = listenersHtml;

                                // Update eye count (participants + 1 host)
                                var eyeEl = document.getElementById('eyeCount');
                                if (eyeEl) eyeEl.innerText = participants.length + 1;

                                // Update receiverSelect for gifts (Only Speakers can receive gifts)
                                var receiverSelect = document.getElementById('receiverSelect');
                                if (receiverSelect) {
                                    var currentUserId = '${sessionScope.currentUser.id}';
                                    var optionsHtml = '';
                                    participants.forEach(p => {
                                        if (p.userId && p.userId != currentUserId && (p.roleInRoom === 'SPEAKER' || p.roleInRoom === 'MODERATOR')) {
                                            optionsHtml += '<option value="' + p.userId + '">' + p.displayName + '</option>';
                                        }
                                    });
                                    receiverSelect.innerHTML = optionsHtml;
                                }

                                // Re-layout the network graph
                                layoutNetworkStage();
                                
                                // ── Update Sidebar Participants List ──
                                const sidebarParticipantsContainer = document.getElementById('sidebarParticipantsContainer');
                                if (sidebarParticipantsContainer) {
                                    const hostUserId = Number('${room.hostUser != null ? room.hostUser.id : -1}');
                                    let sidebarHtml = '';
                                    participants.forEach(p => {
                                        const badgeClass = p.roleInRoom === 'SPEAKER' ? 'bg-primary' : (p.roleInRoom === 'MODERATOR' ? 'bg-warning' : 'bg-secondary');
                                        sidebarHtml += '<div class="d-flex justify-content-between align-items-center p-2 rounded" style="background: rgba(0,0,0,0.2); font-size: 12px;">' +
                                            '<div class="text-truncate me-2">' +
                                                '<div class="fw-bold text-truncate">' + p.displayName + '</div>' +
                                                '<div class="text-muted" style="font-size: 10px;">Role: <span class="badge ' + badgeClass + '">' + p.roleInRoom + '</span></div>' +
                                            '</div>' +
                                            '<div class="d-flex gap-1 flex-shrink-0">';
                                            
                                        if (hostUserId !== -1 && p.userId === hostUserId) {
                                            sidebarHtml += `<span class="text-warning" style="font-size: 10px; font-weight: bold;">👑 Host</span>`;
                                        } else {
                                            const roleLink = `/rooms/${roomId}/toggle-role/${p.id}`;
                                            const micBtnClass = p.micAllowed ? 'btn-warning' : 'btn-outline-success';
                                            const micBtnTitle = p.micAllowed ? 'Revoke microphone' : 'Allow microphone';
                                            const micIconClass = p.micAllowed ? 'bi-mic-mute' : 'bi-mic';
                                            const cleanName = p.displayName.replace(/'/g, "\\'");
                                            
                                            sidebarHtml += `
                                                <a href="${roleLink}" class="btn btn-xs btn-outline-info py-0 px-2 flex-shrink-0" style="font-size: 9px; border-radius: 4px;" title="Promote or Demote">Role</a>
                                                <button type="button" id="staticMicBtn_${p.id}" onclick="setMicPermission('${p.id}')" class="btn btn-xs ${micBtnClass} py-0 px-2 flex-shrink-0" style="font-size:9px;border-radius:4px" title="${micBtnTitle}"><i id="staticMicIcon_${p.id}" class="bi ${micIconClass}"></i></button>
                                                <button type="button" class="btn btn-xs btn-danger py-0 px-2 flex-shrink-0" style="font-size:9px;border-radius:4px" onclick="kickSpeaker('${p.id}', '${cleanName}')" title="Kick user">Kick</button>
                                            `;
                                        }
                                        sidebarHtml += `</div></div>`;
                                    });
                                    sidebarParticipantsContainer.innerHTML = sidebarHtml;
                                }
                            })
                            .catch(err => console.error("Error refreshing participants:", err));
                    }

                    function kickSpeaker(participantId, displayName) {
                        Swal.fire({
                            title: 'Kick ' + displayName + '?',
                            text: 'They will be removed from the room.',
                            icon: 'warning',
                            showCancelButton: true,
                            confirmButtonColor: '#EF4444',
                            cancelButtonColor: '#6C5CE7',
                            confirmButtonText: 'Yes, Kick!',
                            cancelButtonText: 'Cancel',
                            background: '#1E1B4B',
                            color: '#fff'
                        }).then((result) => {
                            if (result.isConfirmed) {
                                fetch('/api/rooms/' + roomId + '/participants/' + participantId, { method: 'DELETE' })
                                    .then(() => {
                                        stompClient.send('/app/room/' + roomId, {}, JSON.stringify({
                                            type: 'PARTICIPANT_KICKED',
                                            senderName: displayName,
                                            content: 'KICKED'
                                        }));
                                        refreshParticipantsUI();
                                        Swal.fire({
                                            icon: 'success', title: 'Kicked!',
                                            text: displayName + ' has been removed.',
                                            background: '#1E1B4B', color: '#fff',
                                            toast: true, position: 'top-end', showConfirmButton: false, timer: 3000
                                        });
                                    })
                                    .catch(err => console.error("Error kicking participant:", err));
                            }
                        });
                    }

                    function forceMuteSpeaker(displayName) {
                        stompClient.send('/app/room/' + roomId, {}, JSON.stringify({
                            type: 'FORCE_MUTE',
                            receiverName: displayName,
                            content: 'MUTE'
                        }));
                        Swal.fire({
                            icon: 'info', title: 'Mute command sent',
                            text: displayName + ' has been muted.',
                            background: '#1E1B4B', color: '#fff',
                            toast: true, position: 'top-end', showConfirmButton: false, timer: 3000
                        });
                    }

                    function setMicPermission(participantId) {
                        fetch('/api/rooms/' + roomId + '/mic-permission/' + participantId, {
                            method: 'POST', credentials: 'same-origin'
                        })
                        .then(function(response) {
                            if (!response.ok) return response.json().then(function(body) { throw new Error(body.error || 'Permission update failed.'); });
                            return response.json();
                        })
                        .then(function(data) {
                            refreshParticipantsUI();
                            var staticBtn = document.getElementById('staticMicBtn_' + participantId);
                            var staticIcon = document.getElementById('staticMicIcon_' + participantId);
                            if (staticBtn && staticIcon) {
                                if (data.micAllowed) {
                                    staticBtn.className = 'btn btn-xs btn-warning py-0 px-2';
                                    staticBtn.title = 'Revoke microphone';
                                    staticIcon.className = 'bi bi-mic-mute';
                                } else {
                                    staticBtn.className = 'btn btn-xs btn-outline-success py-0 px-2';
                                    staticBtn.title = 'Allow microphone';
                                    staticIcon.className = 'bi bi-mic';
                                }
                            }
                            Swal.fire({
                                icon:'success',
                                title:data.micAllowed ? 'Microphone enabled' : 'Microphone revoked',
                                toast:true,position:'top-end',showConfirmButton:false,timer:2200,
                                background:'#1E1B4B',color:'#fff'
                            });
                        })
                        .catch(function(error) {
                            Swal.fire({icon:'error',title:'Could not update microphone',text:error.message,background:'#1E1B4B',color:'#fff'});
                        });
                    }

                    // Network stage layout logic
                    function layoutNetworkStage() {
                        const stage = document.getElementById('networkStage');
                        const svg = document.getElementById('network-lines-svg');
                        const hostNode = document.getElementById('hostNode');
                        const speakers = document.querySelectorAll('.speaker-node');
                        
                        if (!stage || !svg || !hostNode) return;
                        
                        const rect = stage.getBoundingClientRect();
                        const centerX = rect.width / 2;
                        const centerY = rect.height * 0.48;
                        
                        // Clear SVG
                        svg.innerHTML = '';
                        
                        // Keep nodes inside a safe ellipse so labels never collide with the controls.
                        const speakerCount = speakers.length;
                        const radiusX = Math.min(230, Math.max(120, (rect.width - 320) / 2));
                        const radiusY = Math.min(150, Math.max(125, (rect.height - 300) / 2));
                        
                        speakers.forEach((speaker, index) => {
                            const angle = speakerCount === 2
                                ? index * Math.PI
                                : (-Math.PI / 2 + index * 2 * Math.PI / Math.max(speakerCount, 1));
                            const x = centerX + radiusX * Math.cos(angle);
                            const y = centerY + radiusY * Math.sin(angle);
                            
                            speaker.style.left = x + 'px';
                            speaker.style.top = y + 'px';
                            speaker.style.opacity = '1';
                            
                            const line = document.createElementNS('http://www.w3.org/2000/svg', 'line');
                            line.setAttribute('x1', centerX);
                            line.setAttribute('y1', centerY);
                            line.setAttribute('x2', x);
                            line.setAttribute('y2', y);
                            line.setAttribute('stroke', 'rgba(108, 92, 231, 0.4)');
                            line.setAttribute('stroke-width', '2');
                            line.setAttribute('stroke-dasharray', '6,6');
                            
                            const animate = document.createElementNS('http://www.w3.org/2000/svg', 'animate');
                            animate.setAttribute('attributeName', 'stroke-dashoffset');
                            animate.setAttribute('from', '24');
                            animate.setAttribute('to', '0');
                            animate.setAttribute('dur', '1.5s');
                            animate.setAttribute('repeatCount', 'indefinite');
                            line.appendChild(animate);
                            
                            svg.appendChild(line);
                        });
                    }

                    // Auto-join audio when page loads
                    window.addEventListener('load', () => {
                        refreshParticipantsUI();
                        joinChannel();
                    });
                    
                    window.addEventListener('resize', layoutNetworkStage);
                </script>

                <script>
                    var leaveBtn = document.getElementById('globalLeaveBtn');
                    if (leaveBtn) {
                        <c:choose>
                            <c:when test="${room.status == 'SCHEDULED'}">
                                leaveBtn.innerHTML = '<i class="bi bi-play-circle-fill"></i> Start Live Room';
                                leaveBtn.href = '/rooms/${room.id}/go-live';
                                leaveBtn.style.background = '#10B981';
                                leaveBtn.style.color = '#FFFFFF';
                            </c:when>
                            <c:otherwise>
                                leaveBtn.innerHTML = '<i class="bi bi-stop-circle-fill"></i> End Live Room';
                                leaveBtn.href = '/rooms/${room.id}/end';
                                leaveBtn.style.background = '#EF4444';
                                leaveBtn.style.color = '#FFFFFF';
                            </c:otherwise>
                        </c:choose>
                    }
                </script>

            </layout:room>
