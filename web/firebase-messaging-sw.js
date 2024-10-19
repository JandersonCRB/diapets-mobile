importScripts("https://www.gstatic.com/firebasejs/10.14.1/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/10.14.1/firebase-messaging-compat.js");

firebase.initializeApp({
    apiKey: 'AIzaSyAHO1Dw329T6pjl90R40t92FWuHmBRtBe4',
    appId: '1:914226878912:web:fd544e4ec13ae61dfb5025',
    messagingSenderId: '914226878912',
    projectId: 'diapets',
    authDomain: 'diapets.firebaseapp.com',
    measurementId: 'G-5QG288B5ZQ',
});
// Necessary to receive background messages:
const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((payload) => {
    console.log('Received background message: ', payload);
    const notificationTitle = payload.notification.title;
    const notificationOptions = {
        body: payload.notification.body,
        tag: notificationTitle, // tag is added to ovverride the notification with latest update
        icon: payload.notification?.image || payload.data?.image,
        data: {
            url: payload?.data?.openUrl, // This should contain the URL you want to open
        },
    }
});