function checkSession() {
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4) {
            if (xhr.status === 200) {
                console.log("true")
                console.log(xhr.status)
                return true;
            } else {
                window.location.href = "/user/LogIn.html";
            }
        }
    };
    console.log(xhr.open('GET', 'check_session.jsp', true));
    xhr.send();
}