//Email vaildation Regx

String emailregx =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

//Minimum eight characters, at least one letter and one number:

String passwordregx1 = r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$';
// Minimum eight characters, at least one letter, one number and one special character:

String passwordregx2 = r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$';
// Minimum eight characters, at least one uppercase letter, one lowercase letter and one number:

String passwordregx3 = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$';
//Minimum eight characters, at least one uppercase letter, one lowercase letter, one number and one special character:

String passwordregx4 = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
//Minimum eight and maximum 10 characters, at least one uppercase letter, one lowercase letter, one number and one special character:

String passwordregx5 = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,10}$';
