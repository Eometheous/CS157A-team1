function checkSession() {
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4) {
            if (xhr.status === 200) {
                console.log("true")
                return true;
            } else {
                window.location.href = "login.html";
            }
        }
    };
    xhr.open('GET', 'check_session.jsp', true); 
    xhr.send();
}