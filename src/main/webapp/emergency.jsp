<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>

<%
    request.setAttribute("pageTitle", "Emergency");
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

      <!-- ── Page Intro ── -->
      <div class="page-intro">
        <div class="intro-icon">🚑</div>
        <h2>Emergency Contacts</h2>
        <p>Quick access to people and services who can help immediately.</p>
      </div>

      <!-- ═══════════════════════════════════════════
           SECTION 1: NATIONAL HELPLINES (Non-editable)
           ═══════════════════════════════════════════ -->
      <div class="section-label">🏥 National Helplines</div>

      <div class="gs-card emergency-card highlight">
        <div class="card-left">
          <div class="card-icon ambulance-icon">🚑</div>
          <div>
            <h3>National Ambulance</h3>
            <p>India Emergency Medical Service</p>
          </div>
        </div>
        <a href="tel:108" class="btn-danger">Call 108</a>
      </div>

      <div class="gs-card emergency-card helpline-card">
        <div class="card-left">
          <div class="card-icon helpline-icon">🤰</div>
          <div>
            <h3>Janani Suraksha Helpline</h3>
            <p>Maternal &amp; Child Health (Govt. of India)</p>
          </div>
        </div>
        <a href="tel:1800-180-1104" class="btn-helpline">Call 1800-180-1104</a>
      </div>

      <div class="gs-card emergency-card helpline-card">
        <div class="card-left">
          <div class="card-icon helpline-icon">👩‍⚕️</div>
          <div>
            <h3>Women Helpline</h3>
            <p>National Commission for Women</p>
          </div>
        </div>
        <a href="tel:181" class="btn-helpline">Call 181</a>
      </div>

      <div class="gs-card emergency-card helpline-card">
        <div class="card-left">
          <div class="card-icon helpline-icon">🩺</div>
          <div>
            <h3>Health Helpline (NHM)</h3>
            <p>National Health Mission – 24/7</p>
          </div>
        </div>
        <a href="tel:104" class="btn-helpline">Call 104</a>
      </div>

      <div class="gs-card emergency-card helpline-card">
        <div class="card-left">
          <div class="card-icon helpline-icon">🆘</div>
          <div>
            <h3>Emergency (Police/Fire/Ambulance)</h3>
            <p>Universal Emergency Number</p>
          </div>
        </div>
        <a href="tel:112" class="btn-helpline">Call 112</a>
      </div>

      <!-- ═══════════════════════════════════════════
           SECTION 2: PERSONAL CONTACTS (Editable)
           ═══════════════════════════════════════════ -->
      <div class="section-label">👨‍👩‍👧 Your Personal Contacts</div>

      <div id="personalContacts">
        <!-- Contacts will load here from localStorage -->
      </div>

      <button class="btn-add-contact" onclick="openAddModal()">
        <i class="ri-add-circle-line"></i> Add Contact
      </button>

    </div>
  </div>
</div>

<!-- ═══════════════════════════════════════════
     ADD / EDIT CONTACT MODAL
     ═══════════════════════════════════════════ -->
<div class="modal-overlay" id="contactModal">
  <div class="modal-card contact-modal-card">
    <div class="modal-header">
      <h3 id="modalTitle">Add Contact</h3>
      <button class="modal-close" onclick="closeModal()"><i class="ri-close-line"></i></button>
    </div>

    <form id="contactForm" onsubmit="saveContact(event)">
      <input type="hidden" id="editIndex" value="-1" />

      <div class="field">
        <label>Relationship / Label</label>
        <select id="contactLabel">
          <option value="Husband">Husband</option>
          <option value="Mother">Mother</option>
          <option value="Father">Father</option>
          <option value="Sister">Sister</option>
          <option value="Brother">Brother</option>
          <option value="Mother-in-law">Mother-in-law</option>
          <option value="Father-in-law">Father-in-law</option>
          <option value="Doctor">Doctor / OB-GYN</option>
          <option value="Midwife">Midwife</option>
          <option value="Friend">Friend</option>
          <option value="Neighbour">Neighbour</option>
          <option value="Other">Other</option>
        </select>
      </div>

      <div class="field">
        <label>Contact Name</label>
        <input type="text" id="contactName" placeholder="e.g. Rahul Sharma" required />
      </div>

      <div class="field">
        <label>Phone Number</label>
        <input type="tel" id="contactPhone" placeholder="+91 98765 43210" required
               pattern="[\+]?[\d\s\-]{7,15}" title="Enter a valid phone number" />
      </div>

      <div class="modal-actions">
        <button type="button" class="btn cancel-btn" onclick="closeModal()">Cancel</button>
        <button type="submit" class="btn save-btn">Save Contact</button>
      </div>
    </form>
  </div>
</div>

<!-- ═══════════════════════════════════════════
     DELETE CONFIRMATION MODAL
     ═══════════════════════════════════════════ -->
<div class="modal-overlay" id="deleteModal">
  <div class="modal-card delete-modal-card">
    <div class="modal-icon">🗑️</div>
    <h3>Delete Contact?</h3>
    <p id="deleteMsg">Are you sure you want to remove this contact?</p>
    <div class="modal-actions">
      <button class="btn cancel-btn" onclick="closeDeleteModal()">Cancel</button>
      <button class="btn delete-btn" onclick="confirmDelete()">Delete</button>
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
  max-width: 720px;
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
  gap: 14px;
  padding-bottom: 40px;
}

/* ── INTRO ── */
.page-intro {
  text-align: center;
  margin-bottom: 6px;
}
.page-intro .intro-icon {
  font-size: 36px;
  margin-bottom: 6px;
}
.page-intro h2 {
  margin: 0 0 4px;
  font-size: 22px;
  color: #243041;
}
.page-intro p {
  margin: 0;
  color: #64748b;
  font-size: 14px;
}

/* ── SECTION LABEL ── */
.section-label {
  font-size: 15px;
  font-weight: 700;
  color: #475569;
  margin-top: 10px;
  margin-bottom: -4px;
  padding-left: 2px;
}

/* ── EMERGENCY CARDS ── */
.emergency-card {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 18px 20px;
  border-radius: 16px;
  background: #fff;
  box-shadow: 0 4px 14px rgba(0, 0, 0, .06);
  gap: 12px;
  transition: transform 0.2s, box-shadow 0.2s;
}
.emergency-card:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 22px rgba(0, 0, 0, .1);
}

.emergency-card.highlight {
  border: 2px solid #ff6b9a;
  background: #fff5f8;
}

.helpline-card {
  border-left: 3px solid #a78bfa;
}

.card-left {
  display: flex;
  align-items: center;
  gap: 14px;
  flex: 1;
  min-width: 0;
}

.card-icon {
  font-size: 28px;
  width: 48px;
  height: 48px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 12px;
  flex-shrink: 0;
}
.ambulance-icon { background: #ffe0ea; }
.helpline-icon  { background: #ede9fe; }
.personal-icon  { background: #e0f2fe; }

.emergency-card h3 {
  margin: 0;
  font-size: 15px;
  font-weight: 600;
  color: #1e293b;
}
.emergency-card p {
  margin: 2px 0 0;
  font-size: 13px;
  color: #64748b;
}

/* ── CALL BUTTONS ── */
.btn-danger {
  background: linear-gradient(135deg, #ff3b5f, #e53e3e);
  color: #fff;
  padding: 10px 18px;
  border-radius: 12px;
  font-weight: 600;
  text-decoration: none;
  font-size: 13px;
  white-space: nowrap;
  flex-shrink: 0;
  transition: transform 0.15s, box-shadow 0.15s;
}
.btn-danger:hover {
  transform: translateY(-1px);
  box-shadow: 0 6px 16px rgba(255, 59, 95, .3);
}

.btn-helpline {
  background: linear-gradient(135deg, #a78bfa, #8b5cf6);
  color: #fff;
  padding: 10px 16px;
  border-radius: 12px;
  font-weight: 600;
  text-decoration: none;
  font-size: 12px;
  white-space: nowrap;
  flex-shrink: 0;
  transition: transform 0.15s, box-shadow 0.15s;
}
.btn-helpline:hover {
  transform: translateY(-1px);
  box-shadow: 0 6px 16px rgba(139, 92, 246, .3);
}

.btn-call {
  background: linear-gradient(135deg, #34d399, #22c55e);
  color: #fff;
  padding: 10px 18px;
  border-radius: 12px;
  font-weight: 600;
  text-decoration: none;
  font-size: 13px;
  white-space: nowrap;
  flex-shrink: 0;
  transition: transform 0.15s, box-shadow 0.15s;
}
.btn-call:hover {
  transform: translateY(-1px);
  box-shadow: 0 6px 16px rgba(34, 197, 94, .3);
}

/* ── PERSONAL CONTACT CARD ── */
.personal-contact-card {
  border-left: 3px solid #38bdf8;
}

.contact-actions {
  display: flex;
  gap: 8px;
  align-items: center;
  flex-shrink: 0;
}

.btn-edit {
  background: #e0f2fe;
  color: #0284c7;
  border: none;
  width: 36px;
  height: 36px;
  border-radius: 10px;
  font-size: 16px;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: background 0.15s, transform 0.15s;
}
.btn-edit:hover {
  background: #bae6fd;
  transform: scale(1.08);
}

.btn-delete-sm {
  background: #fee2e2;
  color: #dc2626;
  border: none;
  width: 36px;
  height: 36px;
  border-radius: 10px;
  font-size: 16px;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: background 0.15s, transform 0.15s;
}
.btn-delete-sm:hover {
  background: #fecaca;
  transform: scale(1.08);
}

/* ── ADD BUTTON ── */
.btn-add-contact {
  width: 100%;
  padding: 14px;
  border: 2px dashed #cbd5e1;
  border-radius: 14px;
  background: transparent;
  color: #64748b;
  font-size: 15px;
  font-weight: 600;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  transition: border-color 0.2s, color 0.2s, background 0.2s;
}
.btn-add-contact:hover {
  border-color: #ff7aa6;
  color: #ff7aa6;
  background: #fff5f8;
}
.btn-add-contact i {
  font-size: 20px;
}

/* ── EMPTY STATE ── */
.empty-state {
  text-align: center;
  padding: 30px 20px;
  color: #94a3b8;
  font-size: 14px;
}
.empty-state .empty-icon {
  font-size: 40px;
  margin-bottom: 8px;
}

/* ── MODAL OVERRIDES ── */
.contact-modal-card {
  width: 400px;
  max-width: 92%;
  text-align: left;
}
.modal-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 18px;
}
.modal-header h3 {
  margin: 0;
  font-size: 18px;
}
.modal-close {
  background: none;
  border: none;
  font-size: 22px;
  cursor: pointer;
  color: #94a3b8;
  transition: color 0.15s;
}
.modal-close:hover { color: #ef4444; }

.save-btn {
  background: linear-gradient(135deg, #34d399, #22c55e) !important;
  color: #fff !important;
}
.save-btn:hover {
  transform: translateY(-1px);
  box-shadow: 0 6px 14px rgba(34, 197, 94, .3);
}

.delete-modal-card {
  width: 340px;
  max-width: 90%;
}

/* ── MOBILE CARD ADJUSTMENTS ── */
@media (max-width: 520px) {
  .emergency-card {
    flex-direction: column;
    align-items: flex-start;
    gap: 12px;
    padding: 16px;
  }
  .contact-actions,
  .btn-danger,
  .btn-helpline,
  .btn-call {
    align-self: flex-end;
  }
  .card-icon {
    width: 40px;
    height: 40px;
    font-size: 22px;
  }
}
</style>


<script>
/* ═══════════════════════════════════════════════
   PERSONAL CONTACTS – localStorage CRUD
   (Scoped per logged-in user)
   ═══════════════════════════════════════════════ */

// Pull the logged-in user's email from the server session
const USER_EMAIL = '<%= session.getAttribute("email") != null ? session.getAttribute("email") : "" %>';

// Each user gets their own unique localStorage key
const STORAGE_KEY = 'garbhSakhi_emergencyContacts_' + USER_EMAIL;

let deleteIndex = -1;

// ── Default empty templates for brand-new users ──
function getDefaultContacts() {
  return [
    { label: 'Husband', name: '', phone: '' },
    { label: 'Mother',  name: '', phone: '' }
  ];
}

function getContacts() {
  if (!USER_EMAIL) return [];

  const raw = localStorage.getItem(STORAGE_KEY);
  if (!raw) {
    const defaults = getDefaultContacts();
    localStorage.setItem(STORAGE_KEY, JSON.stringify(defaults));
    return defaults;
  }
  return JSON.parse(raw);
}

function setContacts(arr) {
  if (!USER_EMAIL) return;
  localStorage.setItem(STORAGE_KEY, JSON.stringify(arr));
}

// ── Relationship → emoji map ──
function labelEmoji(label) {
  const map = {
    'Husband': '👨', 'Mother': '👩', 'Father': '👴',
    'Sister': '👧', 'Brother': '🧑', 'Mother-in-law': '👩‍🦳',
    'Father-in-law': '👨‍🦳', 'Doctor': '👩‍⚕️', 'Midwife': '🧑‍⚕️',
    'Friend': '🤝', 'Neighbour': '🏠', 'Other': '📞'
  };
  return map[label] || '📞';
}

// ── Render all personal contacts ──
function renderContacts() {
  const container = document.getElementById('personalContacts');

  if (!USER_EMAIL) {
    container.innerHTML =
      '<div class="empty-state">' +
        '<div class="empty-icon">🔒</div>' +
        '<p>Please log in to manage your emergency contacts.</p>' +
      '</div>';
    return;
  }

  const contacts = getContacts();

  if (contacts.length === 0) {
    container.innerHTML =
      '<div class="empty-state">' +
        '<div class="empty-icon">📇</div>' +
        '<p>No personal contacts yet.<br>Tap "Add Contact" to get started.</p>' +
      '</div>';
    return;
  }

  let html = '';
  contacts.forEach(function(c, i) {
    const cleanPhone = c.phone.replace(/[\s\-]/g, '');
    const hasPhone = c.phone && c.phone.trim() !== '';
    const hasName  = c.name  && c.name.trim()  !== '';

    html +=
      '<div class="gs-card emergency-card personal-contact-card">' +
        '<div class="card-left">' +
          '<div class="card-icon personal-icon">' + labelEmoji(c.label) + '</div>' +
          '<div>' +
            '<h3>' + escapeHtml(c.label) + '</h3>' +
            '<p>Name: ' + (hasName ? escapeHtml(c.name) : '<em style="color:#94a3b8;">Not set</em>') + '</p>' +
            '<p>Phone: ' + (hasPhone ? escapeHtml(c.phone) : '<em style="color:#94a3b8;">Not set</em>') + '</p>' +
          '</div>' +
        '</div>' +
        '<div class="contact-actions">' +
          (hasPhone
            ? '<a href="tel:' + cleanPhone + '" class="btn-call">Call</a>'
            : '<span class="btn-call" style="opacity:0.4;pointer-events:none;">Call</span>') +
          '<button class="btn-edit" onclick="openEditModal(' + i + ')" title="Edit">' +
            '<i class="ri-pencil-line"></i>' +
          '</button>' +
          '<button class="btn-delete-sm" onclick="openDeleteModal(' + i + ')" title="Delete">' +
            '<i class="ri-delete-bin-6-line"></i>' +
          '</button>' +
        '</div>' +
      '</div>';
  });

  container.innerHTML = html;
}

// ── Modal helpers ──
function openAddModal() {
  if (!USER_EMAIL) { alert('Please log in first.'); return; }
  document.getElementById('modalTitle').textContent = 'Add Contact';
  document.getElementById('editIndex').value = -1;
  document.getElementById('contactLabel').value = 'Husband';
  document.getElementById('contactName').value = '';
  document.getElementById('contactPhone').value = '';
  document.getElementById('contactModal').style.display = 'flex';
}

function openEditModal(index) {
  const contacts = getContacts();
  const c = contacts[index];
  document.getElementById('modalTitle').textContent = 'Edit Contact';
  document.getElementById('editIndex').value = index;
  document.getElementById('contactLabel').value = c.label;
  document.getElementById('contactName').value = c.name;
  document.getElementById('contactPhone').value = c.phone;
  document.getElementById('contactModal').style.display = 'flex';
}

function closeModal() {
  document.getElementById('contactModal').style.display = 'none';
}

function saveContact(e) {
  e.preventDefault();
  const index = parseInt(document.getElementById('editIndex').value);
  const label = document.getElementById('contactLabel').value;
  const name  = document.getElementById('contactName').value.trim();
  const phone = document.getElementById('contactPhone').value.trim();

  if (!name || !phone) return;

  const contacts = getContacts();
  const entry = { label: label, name: name, phone: phone };

  if (index >= 0 && index < contacts.length) {
    contacts[index] = entry;
  } else {
    contacts.push(entry);
  }

  setContacts(contacts);
  renderContacts();
  closeModal();
}

// ── Delete flow ──
function openDeleteModal(index) {
  deleteIndex = index;
  const contacts = getContacts();
  const displayName = contacts[index].name || contacts[index].label;
  document.getElementById('deleteMsg').textContent =
    'Remove "' + displayName + '" from your emergency contacts?';
  document.getElementById('deleteModal').style.display = 'flex';
}

function closeDeleteModal() {
  document.getElementById('deleteModal').style.display = 'none';
  deleteIndex = -1;
}

function confirmDelete() {
  if (deleteIndex < 0) return;
  const contacts = getContacts();
  contacts.splice(deleteIndex, 1);
  setContacts(contacts);
  renderContacts();
  closeDeleteModal();
}

// ── Close modals on overlay click ──
document.getElementById('contactModal').addEventListener('click', function(e) {
  if (e.target === this) closeModal();
});
document.getElementById('deleteModal').addEventListener('click', function(e) {
  if (e.target === this) closeDeleteModal();
});

// ── Escape HTML to prevent XSS ──
function escapeHtml(str) {
  const div = document.createElement('div');
  div.textContent = str;
  return div.innerHTML;
}

// ── Initialize on page load ──
renderContacts();
</script>