<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="java.util.*, com.garbhsakhi.model.EmergencyContact" %>

<%
    request.setAttribute("pageTitle", "Emergency");
    List<EmergencyContact> contacts = (List<EmergencyContact>) request.getAttribute("contacts");
%>
<%
String msg = (String) session.getAttribute("msg");
if (msg != null) {
%>
  <div class="alert-success"><%= msg %></div>
<%
  session.removeAttribute("msg");
}
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
           SECTION 2: PERSONAL CONTACTS (From Backend)
           ═══════════════════════════════════════════ -->
      <div class="section-label">👨👩👧 Your Personal Contacts</div>

      <div id="personalContacts">
        
        <!-- Add Emergency Contact Form -->
        <div class="gs-card emergency-card add-contact-card">
          <div class="form-card-content">
            <h3>Add Emergency Contact</h3>
            
            <form action="<%= request.getContextPath() %>/emergency" method="post">
              <input type="hidden" name="action" value="add"/>
              
              <div class="field-add-contact">
                <label>Relationship</label>
                <select name="relationship" required class="custom-select">
                  <option value="">Select Relationship</option>
                  <option value="Mother">👩 Mother</option>
                  <option value="Father">👨 Father</option>
                  <option value="Brother">👬 Brother</option>
                  <option value="Sister">👭 Sister</option>
                  <option value="Husband">💍 Husband</option>
                  <option value="Wife">💍 Wife</option>
                  <option value="Son">👦 Son</option>
                  <option value="Daughter">👧 Daughter</option>
                  <option value="Grandmother">👵 Grandmother</option>
                  <option value="Grandfather">👴 Grandfather</option>
                  <option value="Friend">👥 Friend</option>
                  <option value="Neighbor">🏠 Neighbor</option>
                  <option value="Other">📋 Other</option>
                </select>
              </div>

              <div class="field-add-contact">
                <label>Name</label>
                <input name="name" required type="text" class="input-field">
              </div>

              <div class="field-add-contact">
                <label>Phone</label>
                <input name="phone" required type="tel" class="input-field" placeholder="Enter phone number">
              </div>

              <button class="btn-save" type="submit">Save Contact</button>
            </form>
          </div>
        </div>

      <!-- Existing Contacts List -->
      <div style="height: 8px;"></div>
        <% if (contacts != null && !contacts.isEmpty()) { %>
          <% for (EmergencyContact c : contacts) { %>
            <div class="gs-card emergency-card personal-contact-card">
              <div class="card-left">
                <div class="card-icon personal-icon">📞</div>
                <div>
                  <h3><%= c.getRelationship() %></h3>
                  <p>Name: <%= c.getName() %></p>
                  <p>Phone: <%= c.getPhone() %></p>
                </div>
              </div>
          
              <div class="contact-actions">
                <a href="tel:<%= c.getPhone() %>" class="btn-call">Call</a>
                
               <form action="<%= request.getContextPath() %>/emergency" method="post">
                  <input type="hidden" name="action" value="delete"/>
                  <input type="hidden" name="id" value="<%= c.getId() %>"/>
                  <button type="submit" class="btn-delete-sm" title="Delete">🗑</button>
                </form>
              </div>
            </div>
          <% } %>
        <% } else { %>
          <div class="empty-state">
            <div class="empty-icon">📇</div>
            <p>No contacts yet. Add one above.</p>
          </div>
        <% } %>
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
  max-width: 720px;
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
  gap: 14px;
  padding-bottom: 40px;
}

/* ── INTRO ── */
.page-intro {
  text-align: center;
  margin-bottom: 8px;
  width: 100%;
}
.page-intro .intro-icon {
  font-size: 40px;
  margin-bottom: 8px;
}
.page-intro h2 {
  margin: 0 0 6px;
  font-size: 24px;
  color: #243041;
}
.page-intro p {
  margin: 0;
  color: #64748b;
  font-size: 14px;
  line-height: 1.5;
}

/* ── SECTION LABEL ── */
.section-label {
  font-size: 16px;
  font-weight: 700;
  color: #475569;
  margin-top: 16px;
  margin-bottom: 8px;
  padding-left: 4px;
  width: 100%;
}

/* ── EMERGENCY CARDS ── */
.emergency-card {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 24px 24px;
  border-radius: 16px;
  background: #fff;
  box-shadow: 0 4px 14px rgba(0, 0, 0, .06);
  gap: 16px;
  transition: transform 0.2s, box-shadow 0.2s;
  width: 100%;
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
  border-left: 4px solid #a78bfa;
}

.personal-contact-card {
  border-left: 4px solid #38bdf8;
}

.add-contact-card {
  border-left: 4px solid #34d399;
}

/* TWEAK: Add inner content wrapper for better padding */
.form-card-content {
  width: 100%;
  padding: 24px;
}

.card-left {
  display: flex;
  align-items: center;
  gap: 16px;
  flex: 1;
  min-width: 0;
}

.card-icon {
  font-size: 32px;
  width: 56px;
  height: 56px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 14px;
  flex-shrink: 0;
}
.ambulance-icon { background: #ffe0ea; }
.helpline-icon  { background: #ede9fe; }
.personal-icon  { background: #e0f2fe; }

.emergency-card h3 {
  margin: 0;
  font-size: 16px;
  font-weight: 600;
  color: #1e293b;
  line-height: 1.3;
}

/* Center form heading */
.add-contact-card h3 {
  text-align: left;
  margin-bottom: 20px;
  font-size: 18px;
  color: #1e293b;
}

/* ── CALL BUTTONS ── */
.btn-danger, .btn-helpline, .btn-call, .btn-save {
  border: none;
  cursor: pointer;
  font-family: inherit;
}

.btn-danger {
  background: linear-gradient(135deg, #ff3b5f, #e53e3e);
  color: #fff;
  padding: 12px 22px;
  border-radius: 12px;
  font-weight: 600;
  text-decoration: none;
  font-size: 14px;
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
  padding: 12px 20px;
  border-radius: 12px;
  font-weight: 600;
  text-decoration: none;
  font-size: 13px;
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
  padding: 0 20px;
  height: 44px;
  line-height: 44px;
  border-radius: 12px;
  font-weight: 600;
  text-decoration: none;
  font-size: 13px;
  white-space: nowrap;
  flex-shrink: 0;
  transition: transform 0.15s, box-shadow 0.15s;
  display: inline-flex;
  align-items: center;
}
.btn-call:hover {
  transform: translateY(-1px);
  box-shadow: 0 6px 16px rgba(34, 197, 94, .3);
}

.contact-actions {
  display: flex;
  gap: 8px;
  align-items: center;
  flex-shrink: 0;
  line-height: 0;
}

.contact-actions form {
  display: flex;
  align-items: center;
  margin: 0;
  padding: 0;
  line-height: 0;
}

.btn-delete-sm {
  background: #fee2e2;
  color: #dc2626;
  border: none;
  width: 38px;
  height: 38px;
  border-radius: 10px;
  font-size: 18px;
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

/* ── FORM STYLES ── */
.field-add-contact {
  margin-bottom: 20px;
}
.field-add-contact:last-child {
  margin-bottom: 0;
}

.field-add-contact label {
  display: block;
  margin-bottom: 8px;
  font-weight: 600;
  color: #374151;
  font-size: 14px;
}

.input-field, .custom-select {
  width: 100%;
  padding: 14px 16px;
  border: 2px solid #e2e8f0;
  border-radius: 10px;
  font-size: 15px;
  transition: border-color 0.2s, box-shadow 0.2s;
  box-sizing: border-box;
  background-color: #fff;
}

.input-field:focus, .custom-select:focus {
  outline: none;
  border-color: #34d399;
  box-shadow: 0 0 0 4px rgba(52, 211, 153, 0.15);
}

.custom-select {
  padding: 14px 40px 14px 16px;
  background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='%2364748b' viewBox='0 0 16 16'%3E%3Cpath d='M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z'/%3E%3C/svg%3E");
  background-repeat: no-repeat;
  background-position: right 12px center;
  cursor: pointer;
  -webkit-appearance: none;
  -moz-appearance: none;
  appearance: none;
}

.btn-save {
  background: linear-gradient(135deg, #34d399, #22c55e);
  color: #fff;
  width: 100%;
  padding: 16px 20px;
  border-radius: 12px;
  font-weight: 600;
  border: none;
  font-size: 15px;
  cursor: pointer;
  transition: transform 0.15s, box-shadow 0.15s;
}
.btn-save:hover {
  transform: translateY(-1px);
  box-shadow: 0 6px 16px rgba(34, 197, 94, .3);
}

/* ── EMPTY STATE ── */
.empty-state {
  text-align: center;
  padding: 40px 20px;
  color: #94a3b8;
  font-size: 15px;
}
.empty-state .empty-icon {
  font-size: 48px;
  margin-bottom: 12px;
}

/* ── MOBILE CARD ADJUSTMENTS ── */
@media (max-width: 520px) {
  .emergency-card {
    flex-direction: column;
    align-items: stretch;
    gap: 16px;
    padding: 20px;
  }
  .form-card-content {
    padding: 20px;
  }
  .contact-actions,
  .btn-danger,
  .btn-helpline,
  .btn-call {
    align-self: stretch;
    text-align: center;
  }
  .card-icon {
    width: 48px;
    height: 48px;
    font-size: 26px;
  }
}
</style>