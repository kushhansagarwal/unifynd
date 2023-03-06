const express = require('express');
const admin = require("firebase-admin");
const app = express();

const serviceAccount = require("./unifynd-hoth-firebase-adminsdk-gzyt1-b44d0dd915.json");

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
});

app.use(express.json());

//make a route

app.get('/', (req, res) => {
    return res.json({
        status: "success",
        data: {
            message: "Hello World"
        }
    });
}
);

app.post('/', (req, res) => {
    return res.json({
        status: "success",
        data: {
            message: "Hello World"
        }
    });
}
);

app.get('/clubs/getClubs', (req, res) => {
    admin.firestore().collection('clubs').orderBy("name").get()
        .then((snapshot) => {
            let clubs = [];
            snapshot.forEach((doc) => {
                var club_data = doc.data();
                club_data.id = doc.id;
                clubs.push(club_data);
            });
            return res.json({
                status: "success",
                data: {
                    clubs
                }
            });
        })
}
);

app.get('/restaurants/getRestaurants', (req, res) => {
    admin.firestore().collection('restaurants').orderBy("activity").get()
        .then((snapshot) => {
            let restaurants = [];
            snapshot.forEach((doc) => {
                restaurants.push(doc.data());
            });
            return res.json({
                status: "success",
                data: {
                    restaurants: restaurants
                }
            });
        })
}
);

app.get('/organizations/getOrganizations', (req, res) => {
    admin.firestore().collection('campus_organizations').orderBy("name").get()
        .then((snapshot) => {
            let clubs = [];
            snapshot.forEach((doc) => {
                var club_data = doc.data();
                club_data.id = doc.id;
                //print name and id in same line
                console.log(club_data.name + " " + club_data.id);
                clubs.push(club_data);
            });
            return res.json({
                status: "success",
                data: {
                    clubs
                }
            });
        })
}
);

app.get('/marketplace/getMarketplace', (req, res) => {
    admin.firestore().collection('marketplace').orderBy("category").get()
        .then((snapshot) => {
            let services = [];
            snapshot.forEach((doc) => {
                var service = doc.data();
                service.id = doc.id;
                services.push(service);
            });
            return res.json({
                status: "success",
                data: {
                    services: services
                }
            });
        })
}
);

//make one route for /events/getEvents

app.get('/events/getEvents', (req, res) => {
    admin.firestore().collection('events').orderBy("event_name").get()

        .then((snapshot) => {
            let events = [];
            snapshot.forEach((doc) => {
                var event = doc.data();
                event.id = doc.id;
                events.push(event);
            });
            return res.json({
                status: "success",
                data: {
                    events: events
                }
            });
        })
}
);

//make a post request that takes in a service id and adds a review to it with date, name, rating, and review
app.post('/marketplace/addReview', (req, res) => {
    const service_id = req.body.service_id;
    const review = req.body.review;
    const rating = req.body.rating;
    const name = req.body.name;
    const date = req.body.date;

    //update the array in the document named reviews
    admin.firestore().collection('marketplace').doc(service_id).update({
        reviews: admin.firestore.FieldValue.arrayUnion({
            review: review,
            rating: rating,
            name: name,
            date: date
        })
    })

        .then(() => {
            return res.json({
                status: "success",
                data: {
                    message: "Review added successfully"
                }
            });
        })
        .catch((err) => {
            return res.json({
                status: "error",
                data: {
                    message: err
                }
            });
        })
}
);


//listen on port or env port
const port = process.env.PORT || 5000;
app.listen(port, () => {
    console.log(`Server running on port ${port}`);
}
);
