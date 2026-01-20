function openSidebar() {
    document.getElementById("sidebar").classList.add("mobile-visible");
    document.getElementById("overlay").style.display = "block";
}

function closeSidebar() {
    document.getElementById("sidebar").classList.remove("mobile-visible");
    document.getElementById("overlay").style.display = "none";
}
