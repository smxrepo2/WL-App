var admin = require("firebase-admin");

var serviceAccount = require("D:/Work/Flutter/weightchoper-1/serviceAccountKey.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});
// This registration token comes from the client FCM SDKs.
//var registrationToken = 'cqzrxJjSQD29FAOBDzyBP5:APA91bF7A7Z_f21_m5XGgwM17lcoiNEGX5sUqfpygnd2alokQ1nWdDI23xE4q1Hv0taT12jaQ00mTWzgGuBVyDO9yyvfsxkq47iOaYcQPyfjuvpw5qmDByO7lLzr471RNHFCtMS_ALmH';

var message = {
  notification: {
    title: 'Water',
    body: 'This is test to send to water subscriptions'
  },
  // token: registrationToken
};

// Send a message to the device corresponding to the provided
// registration token.
admin.messaging().sendToTopic('Water', message)
  .then((response) => {
    // Response is a message ID string.
    console.log('Successfully sent message:', response);
  })
  .catch((error) => {
    console.log('Error sending message:', error);
  });