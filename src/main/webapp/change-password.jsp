<%@ page session="true" %>
<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    request.setAttribute("pageTitle", "Change Password");
%>

<jsp:include page="components/header.jsp" />
<jsp:include page="components/sidebar.jsp" />
<jsp:include page="components/bottom-nav.jsp" />
<jsp:include page="components/fab-emergency.jsp" />

<link rel="stylesheet" href="assets/css/style.css">
<link rel="stylesheet" href="assets/css/modern-style.css">

<div class="page-container">
  <div class="content-wrapper">
    <div class="center-stack">

      <!-- ── Page Header ── -->
      <div class="page-header">
        <div class="header-icon">
          <i class="ri-lock-line"></i>
        </div> 
        <h2>Security Settings</h2>
        <p class="header-subtitle">Update your password to keep your account secure</p>
      </div>

      <!-- ── Change Password Card ── -->
      <div class="gs-card settings-card security-card">
        
        <div class="card-header">
          <div class="lock-icon">
            <i class="ri-lock-line lock-symbol"></i>
          </div>
          <div class="header-content">
            <h3>Change Password</h3>
            <p class="secure-note">For security reasons, you will be logged out after updating your password.</p>
          </div>
        </div>

        <form action="<%= request.getContextPath() %>/change-password"
              method="post"
              class="form-stack"
              onsubmit="return validatePasswordMatch()">

          <!-- CURRENT PASSWORD -->
          <div class="form-group current-password-group">
            <label for="currentPassword">
              <span class="label-text">Current Password</span>
              <span class="required">*</span>
            </label>
            <div class="password-input-wrapper">
              <input type="password"
                     id="currentPassword"
                     name="currentPassword"
                     required
                     placeholder="Enter your current password"
                     autocomplete="off">
              <button type="button" 
                      class="toggle-visibility-btn" 
                      onclick="togglePasswordVisibility(this)"
                      title="Show/Hide Password">
                <i class="ri-eye-line"></i>
              </button>
            </div>
          </div>

          <!-- NEW PASSWORD -->
          <div class="form-group new-password-group">
            <label for="newPassword">
              <span class="label-text">New Password</span>
              <span class="required">*</span>
            </label>
            <div class="password-input-wrapper">
              <input type="password"
                     id="newPassword"
                     name="newPassword"
                     required
                     placeholder="Create a strong password"
                     oninput="checkStrength(this.value,'pwdStrength')"
                     minlength="8"
                     data-pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&#]).{8,}$">
              <button type="button" 
                      class="toggle-visibility-btn" 
                      onclick="togglePasswordVisibility(this)"
                      title="Show/Hide Password">
                <i class="ri-eye-line"></i>
              </button>
            </div>

            <!-- STRENGTH METER (ENHANCED) -->
            <div id="pwdStrength" class="strength-meter enhanced-meter">
              <div class="strength-bar-container">
                <div class="strength-bar">
                  <div class="strength-fill"></div>
                </div>
              </div>
              <div class="strength-info">
                <span class="strength-text"></span>
                <span class="strength-score"></span>
              </div>
            </div>

            <!-- RECOMMENDATIONS -->
            <div class="password-requirements">
              <div class="req-item" data-req="length">
                <i class="ri-checkbox-circle-line"></i>
                <span>At least 8 characters</span>
              </div>
              <div class="req-item" data-req="uppercase">
                <i class="ri-checkbox-circle-line"></i>
                <span>Uppercase letter</span>
              </div>
              <div class="req-item" data-req="lowercase">
                <i class="ri-checkbox-circle-line"></i>
                <span>Lowercase letter</span>
              </div>
              <div class="req-item" data-req="number">
                <i class="ri-checkbox-circle-line"></i>
                <span>Number (0-9)</span>
              </div>
              <div class="req-item" data-req="special">
                <i class="ri-checkbox-circle-line"></i>
                <span>Special character (@$!%*?&amp;)</span>
              </div>
            </div>
          </div>

          <!-- CONFIRM PASSWORD -->
          <div class="form-group confirm-password-group">
            <label for="confirmPassword">
              <span class="label-text">Confirm New Password</span>
              <span class="required">*</span>
            </label>
            <div class="password-input-wrapper">
              <input type="password"
                     id="confirmPassword"
                     name="confirmPassword"
                     required
                     placeholder="Re-enter your new password">
              <button type="button" 
                      class="toggle-visibility-btn" 
                      onclick="togglePasswordVisibility(this)"
                      title="Show/Hide Password">
                <i class="ri-eye-line"></i>
              </button>
            </div>
            <div id="matchMessage" class="match-message"></div>
          </div>

          <!-- UPDATE BUTTON -->
          <div class="form-actions">
            <button type="submit" class="btn-primary btn-large">
              <div class="header-icon">
                <i class="ri-lock-line"></i>
              </div> 
              Update Password
            </button>
          </div>

          <!-- ERROR MESSAGE -->
          <% if (request.getParameter("error") != null) { %>
            <div class="alert alert-error">
              <i class="ri-error-warning-line"></i>
              <span>Password update failed. Please check your current password.</span>
            </div>
          <% } %>

          <!-- SUCCESS MESSAGE (from backend) -->
          <% if (request.getAttribute("success") != null) { %>
            <div class="alert alert-success">
              <i class="ri-check-double-line"></i>
              <span>Password updated successfully!</span>
            </div>
          <% } %>

        </form>

      </div>

    </div>
  </div>
</div>

<style>
/* ── PAGE CONTAINER ── */
.page-container {
  padding-top: 80px;
  width: 100%;
  display: flex;
  justify-content: center;
  box-sizing: border-box;
}

.content-wrapper {
  width: 100%;
  max-width: 600px;
  margin: 0 auto;
  padding: 0 24px;
}

@media (min-width: 901px) {
  .page-container { padding-left: 260px; }
  .content-wrapper { padding: 0 40px; }
}

@media (max-width: 900px) {
  .page-container { padding-left: 0; padding-bottom: 90px; }
  .content-wrapper { padding: 0 16px; }
}

.center-stack {
  width: 100%;
  display: flex;
  flex-direction: column;
  gap: 20px;
  padding-bottom: 40px;
}

/* ── PAGE HEADER ── */
.page-header {
  text-align: center;
  margin-bottom: 8px;
}
.page-header .header-icon {
  font-size: 48px;
  margin-bottom: 12px;
}
.page-header h2 {
  margin: 0 0 6px;
  font-size: 28px;
  color: #243041;
  font-weight: 700;
}
.header-subtitle {
  margin: 0;
  color: #64748b;
  font-size: 15px;
  line-height: 1.5;
}

/* ── SETTINGS CARD ── */
.settings-card {
  background: #fff;
  border-radius: 20px;
  box-shadow: 0 8px 24px rgba(0, 0, 0, .08);
  overflow: hidden;
  position: relative;
}

.security-card::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 6px;
  background: linear-gradient(135deg, #f02e5c, #f72e73, #f72e73, #ff3b5f);
}

.card-header {
  padding: 28px 32px 20px;
  background: linear-gradient(135deg, #fdf2f5, #fff);
  border-bottom: 1px solid #f0eef5;
}

.lock-icon {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 48px;
  height: 48px;
  background: linear-gradient(135deg, #ffe5ec, #ffd1de);
  border-radius: 14px;
  margin-bottom: 16px;
}

.lock-symbol {
  font-size: 24px;
}

.header-content h3 {
  margin: 0 0 8px;
  font-size: 22px;
  font-weight: 700;
  color: #243041;
}

.secure-note {
  margin: 0;
  color: #64748b;
  font-size: 14px;
  line-height: 1.5;
}

/* ── FORM GROUPS ── */
.form-stack {
  padding: 24px 32px 32px;
}

.form-group {
  margin-bottom: 24px;
}
.form-group:last-child {
  margin-bottom: 0;
}

.form-group label {
  display: block;
  margin-bottom: 10px;
  font-weight: 600;
  color: #374151;
  font-size: 15px;
}

.required {
  color: #ff3b5f;
  margin-left: 4px;
}

/* ── PASSWORD INPUT WRAPPER ── */
.password-input-wrapper {
  position: relative;
  width: 100%;
}

.password-input-wrapper input {
  width: 100%;
  padding: 14px 48px 14px 16px;
  border: 2px solid #e2e8f0;
  border-radius: 12px;
  font-size: 15px;
  transition: all 0.2s ease;
  box-sizing: border-box;
  background-color: #fff;
}

.password-input-wrapper input:focus {
  outline: none;
  border-color: #ff3b5f;
  box-shadow: 0 0 0 4px rgba(255, 59, 95, 0.1);
}

.password-input-wrapper input.error {
  border-color: #ff3b5f;
  box-shadow: 0 0 0 4px rgba(255, 59, 95, 0.1);
}

.toggle-visibility-btn {
  position: absolute;
  right: 12px;
  top: 50%;
  transform: translateY(-50%);
  background: none;
  border: none;
  cursor: pointer;
  color: #64748b;
  font-size: 20px;
  padding: 8px;
  transition: color 0.2s;
}

.toggle-visibility-btn:hover {
  color: #ff3b5f;
}

/* ── STRENGTH METER (ENHANCED) ── */
.enhanced-meter {
  margin-top: 16px;
  padding: 16px;
  background: #f8fafc;
  border-radius: 10px;
}

.strength-bar-container {
  margin-bottom: 8px;
}

.strength-bar {
  height: 6px;
  background: #e2e8f0;
  border-radius: 3px;
  overflow: hidden;
}

.strength-fill {
  height: 100%;
  width: 0%;
  border-radius: 3px;
  transition: all 0.3s ease;
}

.strength-fill.weak { background: #ff3b5f; width: 25%; }
.strength-fill.fair { background: #ffc107; width: 50%; }
.strength-fill.good { background: #ff9800; width: 75%; }
.strength-fill.strong { background: #4caf50; width: 100%; }

.strength-info {
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-size: 13px;
}

.strength-text {
  font-weight: 600;
  color: #243041;
}

.strength-score {
  color: #64748b;
}

/* ── PASSWORD REQUIREMENTS ── */
.password-requirements {
  margin-top: 16px;
  padding: 16px;
  background: #f8fafc;
  border-radius: 10px;
}

.req-item {
  display: flex;
  align-items: center;
  gap: 10px;
  font-size: 13px;
  color: #64748b;
  margin-bottom: 8px;
}

.req-item:last-child {
  margin-bottom: 0;
}

.req-item i {
  font-size: 16px;
  transition: color 0.2s;
}

.req-item.completed {
  color: #4caf50;
}

.req-item.completed i {
  color: #4caf50;
}

.req-item.pending {
  color: #cbd5e1;
}

.req-item.pending i {
  color: #cbd5e1;
}

/* ── MATCH MESSAGE ── */
.match-message {
  margin-top: 8px;
  font-size: 13px;
  min-height: 20px;
}

.match-message.valid {
  color: #4caf50;
}

.match-message.invalid {
  color: #ff3b5f;
}

/* ── FORM ACTIONS ── */
.btn-primary {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 10px;
  width: 100%;
  padding: 16px 24px;
  border: none;
  border-radius: 12px;
  font-weight: 600;
  font-size: 16px;
  cursor: pointer;
  transition: all 0.2s ease;
  color: #fff;
}

.btn-large {
  padding: 18px 24px;
  font-size: 16px;
}

.btn-primary {
  background: linear-gradient(135deg, #ff3b5f, #e53e3e);
}

.btn-primary:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 24px rgba(255, 59, 95, 0.3);
}

.btn-primary:active {
  transform: translateY(0);
}

/* ── ALERTS ── */
.alert {
  padding: 16px 20px;
  border-radius: 12px;
  display: flex;
  align-items: center;
  gap: 12px;
  font-size: 14px;
  margin-top: 16px;
}

.alert-error {
  background: #ffe5e8;
  color: #dc2626;
  border: 1px solid #fecaca;
}

.alert-success {
  background: #d1fae5;
  color: #059669;
  border: 1px solid #a7f3d0;
}

.alert i {
  font-size: 20px;
}

/* ── EMPTY STATE ── */
.empty-state {
  text-align: center;
  padding: 60px 20px;
  color: #94a3b8;
}
.empty-state .empty-icon {
  font-size: 64px;
  margin-bottom: 16px;
}
.empty-state p {
  font-size: 15px;
}
</style>

<!-- ✅ PASSWORD UTILITIES SCRIPT -->
<script src="assets/js/password-utils.js"></script>

<!-- NEW ENHANCED SCRIPT -->
<script>
// Toggle Password Visibility
function togglePasswordVisibility(btn) {
  const wrapper = btn.parentElement;
  const input = wrapper.querySelector('input');
  const icon = btn.querySelector('i');
  
  if (input.type === 'password') {
    input.type = 'text';
    icon.className = 'ri-eye-off-line';
  } else {
    input.type = 'password';
    icon.className = 'ri-eye-line';
  }
}

// Check Password Match
function validatePasswordMatch() {
  const newPass = document.getElementById('newPassword');
  const confirmPass = document.getElementById('confirmPassword');
  const matchMsg = document.getElementById('matchMessage');
  
  if (newPass.value !== confirmPass.value) {
    matchMsg.textContent = 'Passwords do not match';
    matchMsg.className = 'match-message invalid';
    confirmPass.classList.add('error');
    setTimeout(() => {
      confirmPass.classList.remove('error');
      matchMsg.textContent = '';
      matchMsg.className = 'match-message';
    }, 3000);
    return false;
  }
  
  matchMsg.textContent = '✓ Passwords match';
  matchMsg.className = 'match-message valid';
  return true;
}

// Enhanced Password Strength Checker
function checkStrength(password, strengthId) {
  const strengthEl = document.getElementById(strengthId);
  const fillEl = strengthEl.querySelector('.strength-fill');
  const textEl = strengthEl.querySelector('.strength-text');
  const reqItems = document.querySelectorAll('.req-item');
  
  let score = 0;
  let requirements = {};
  
  // Check requirements
  requirements.length = password.length >= 8;
  requirements.uppercase = /[A-Z]/.test(password);
  requirements.lowercase = /[a-z]/.test(password);
  requirements.number = /\d/.test(password);
  requirements.special = /[@$!%*?&]/.test(password);
  
  // Score
  Object.values(requirements).forEach(req => {
    if (req) score++;
  });
  
  // Update progress bar
  if (score <= 2) {
    fillEl.className = 'strength-fill weak';
    textEl.textContent = 'Weak';
  } else if (score <= 3) {
    fillEl.className = 'strength-fill fair';
    textEl.textContent = 'Fair';
  } else if (score <= 4) {
    fillEl.className = 'strength-fill good';
    textEl.textContent = 'Good';
  } else {
    fillEl.className = 'strength-fill strong';
    textEl.textContent = 'Strong';
  }
  
  // Update requirements checklist
  reqItems.forEach(item => {
    const reqName = item.dataset.req;
    if (requirements[reqName]) {
      item.classList.add('completed');
      item.classList.remove('pending');
    } else {
      item.classList.remove('completed');
      item.classList.add('pending');
    }
  });
}

// Real-time validation on blur
document.addEventListener('DOMContentLoaded', () => {
  const newPassword = document.getElementById('newPassword');
  const confirmPassword = document.getElementById('confirmPassword');
  
  if (newPassword) {
    newPassword.addEventListener('blur', () => checkStrength(newPassword.value, 'pwdStrength'));
  }
  
  if (confirmPassword) {
    confirmPassword.addEventListener('blur', () => {
      if (confirmPassword.value && newPassword.value) {
        validatePasswordMatch();
      }
    });
  }
});
</script>