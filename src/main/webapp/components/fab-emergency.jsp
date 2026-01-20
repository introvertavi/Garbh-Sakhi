<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!-- 🌸 Emergency Floating Action Button -->
<div class="fab-emergency" title="Emergency" onclick="triggerEmergency()">
  <i class="ri-phone-fill"></i>
</div>

<script>
  function triggerEmergency() {
    // small placeholder — implement SMS / call logic later
    if (confirm('🚨 Trigger emergency alert? This will notify saved contacts.')) {
      // TODO: call server endpoint to send alerts
      alert('Emergency alert triggered (stub).');
    }
  }
</script>

<style>
/* 🌸 Emergency FAB – consistent pastel theme */
.fab-emergency {
  position: fixed;
  bottom: calc(var(--gs-bottomnav-h, 70px) + 22px); /* avoids overlap with bottom nav */
  right: 22px;
  width: 64px;
  height: 64px;
  background: linear-gradient(135deg, #ff8ab4, #ff4f93);
  color: #fff;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 26px;
  box-shadow: 0 8px 20px rgba(255, 79, 147, 0.25);
  cursor: pointer;
  z-index: 2100;
  transition: all 0.25s ease;
}

/* Hover glow effect */
.fab-emergency:hover {
  transform: scale(1.08);
  box-shadow: 0 10px 28px rgba(255, 79, 147, 0.35);
}

/* Responsive mobile tweaks */
@media (max-width: 900px) {
  .fab-emergency {
    bottom: calc(var(--gs-bottomnav-h, 64px) + 16px);
    right: 18px;
    width: 58px;
    height: 58px;
    font-size: 24px;
  }
}
</style>