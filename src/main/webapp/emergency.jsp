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
      <div class="section-label">👨‍👩‍👧 Your Personal Contacts</div>

      <div id="personalContacts">
        <!-- Add Emergency Contact Form -->
        <div class="gs-card" style="margin-top:10px;">
          <h3 style="margin-bottom:10px;">Add Emergency Contact</h3>
          
          <form action="<%= request.getContextPath() %>/emergency" method="post">

  <input type="hidden" name="action" value="add"/>

  <div class="field">
    <label>Label</label>
    <input name="label" required>
  </div>

  <div class="field">
    <label>Name</label>
    <input name="name" required>
  </div>

  <div class="field">
    <label>Phone</label>
    <input name="phone" required>
  </div>

  <button class="btn-call" type="submit">Save Contact</button>

</form>
        </div>

        <!-- Existing Contacts List -->
        <% if (contacts != null && !contacts.isEmpty()) { %>
          <% for (EmergencyContact c : contacts) { %>
            <div class="gs-card emergency-card personal-contact-card">
              <div class="card-left">
                <div class="card-icon personal-icon">📞</div>
                <div>
                  <h3><%= c.getLabel() %></h3>
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

/* ── FORM STYLES ── */
.field {
  margin-bottom: 15px;
}
.field label {
  display: block;
  margin-bottom: 5px;
  font-weight: 600;
  color: #374151;
}
.field input {
  width: 100%;
  padding: 8px 12px;
  border: 1px solid #d1d5db;
  border-radius: 8px;
  font-size: 14px;
}
.field input:focus {
  outline: none;
  border-color: #34d399;
  box-shadow: 0 0 0 3px rgba(52, 211, 153, 0.1);
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