const WebSocket = require("ws");

const wss = new WebSocket.Server({ port: 8080 });

const messageTypes = {
  GET_DATA: "GET_DATA",
  UPDATE_DATA: "UPDATE_DATA"
};
let todoItems = [];

console.log("run sockets server");

const sendData = data => {
  // Broadcast
  wss.clients.forEach(client => {
    client.send(JSON.stringify(data));
  });
};

wss.on("connection", function connection(ws) {
  console.log("new connection");
  ws.on("message", function incoming(message) {
    const { type, payload } = JSON.parse(message);
    switch (type) {
      case messageTypes.GET_DATA: {
        sendData(todoItems);
        break;
      }
      case messageTypes.UPDATE_DATA: {
        todoItems = payload;
        sendData(todoItems);
        break;
      }
      default:
        console.log("Wrong message type" + type);
    }
  });
});
