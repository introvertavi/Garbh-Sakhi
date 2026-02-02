/* ============================= */
/* SHOW / HIDE PASSWORD (FIXED) */
/* ============================= */
function togglePassword(btn) {
  // Works for login, signup, change password
  const wrapper =
    btn.closest(".password-input-wrapper") ||
    btn.closest(".password-field");

  if (!wrapper) return;

  const input = wrapper.querySelector("input");
  if (!input) return;

  if (input.type === "password") {
    input.type = "text";
    btn.classList.remove("ri-eye-line");
    btn.classList.add("ri-eye-off-line");
  } else {
    input.type = "password";
    btn.classList.remove("ri-eye-off-line");
    btn.classList.add("ri-eye-line");
  }
}

/* ============================= */
/* PASSWORD STRENGTH (UNCHANGED) */
/* ============================= */
function checkStrength(input, meterId) {
  const meter = document.getElementById(meterId);
  if (!meter) return;

  const fill = meter.querySelector(".strength-fill");
  const text = meter.querySelector(".strength-text");
  const val = input.value;

  let strength = 0;
  if (val.length >= 6) strength++;
  if (/[A-Z]/.test(val)) strength++;
  if (/[0-9]/.test(val)) strength++;
  if (/[^A-Za-z0-9]/.test(val)) strength++;

  // RESET
  fill.style.width = "0%";
  fill.className = "strength-fill";
  text.textContent = "";
  text.style.color = "";

  if (!val) return;

  if (strength <= 1) {
    fill.style.width = "33%";
    fill.classList.add("strength-weak");
    text.textContent = "Weak password";
    text.style.color = "#ef4444"; // red
  }
  else if (strength <= 3) {
    fill.style.width = "66%";
    fill.classList.add("strength-medium");
    text.textContent = "Medium strength";
    text.style.color = "#f59e0b"; // yellow
  }
  else {
    fill.style.width = "100%";
    fill.classList.add("strength-strong");
    text.textContent = "Strong password";
    text.style.color = "#22c55e"; // green
  }
}
