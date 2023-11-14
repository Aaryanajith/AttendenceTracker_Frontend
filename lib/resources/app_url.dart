class AppUrl {
  // static var baseUrl = 'http://10.0.2.2:8000/';
  static var baseUrl = 'https://IvinJ.pythonanywhere.com/';
  static var login = '${baseUrl}api/jwt/token/';
  static var refreshToken = '${baseUrl}api/jwt/token/refresh/';
  static var addEvent = '${baseUrl}create_event/';
  static var getEvent = '${baseUrl}get_events/';
  static var deleteEvent = '${baseUrl}delete_event/';
  static var getAttendees = '${baseUrl}get_attendees/';
  static var markAttendence = '${baseUrl}mark_attendence/';
}
