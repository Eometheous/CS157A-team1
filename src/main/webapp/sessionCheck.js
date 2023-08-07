function checkSession() {
    console.log("running");
    
    try{
        fetch('../check_session.jsp')
            .then(response => {
                if (response.ok) {
                    console.log("true");
                } else {
                    console.log("returning false")
                    window.location.href = "/user/LogIn.html";
                }
            })
            .catch(error => {
                console.error("Error occurred:", error);
                window.location.href = "/user/LogIn.html";
            });
        }catch {
            console.log("returning false")
            window.location.href = "/user/LogIn.html";
    }
}
