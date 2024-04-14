const baseUrl = "https://api.openrouteservice.org/v2/directions/driving-car";
const apiKey ="914dea0a4e48423e8af1c0ac35cac48a";
getRouteUrl(String startPoint, String endPoint) {
  return Uri.parse("https://api.geoapify.com/v1/routing?waypoints=${startPoint}|${endPoint}&mode=drive&apiKey=${apiKey}");
}
