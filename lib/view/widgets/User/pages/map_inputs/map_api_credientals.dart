const baseUrl = "https://api.openrouteservice.org/v2/directions/driving-car";
const apiKey =
    "5b3ce3597851110001cf6248c7bd4833ac504464a5c8a4d38c1472ca5b3ce3597851110001cf6248c7bd4833ac504464a5c8a4d38c1472ca";
getRouteUrl(String startPoint, String endPoint) {
  return Uri.parse(
      "https://api.openrouteservice.org/v2/directions/driving-car?api_key=5b3ce3597851110001cf6248c7bd4833ac504464a5c8a4d38c1472ca&start=8.681495,49.41461&end=${endPoint}");
}
