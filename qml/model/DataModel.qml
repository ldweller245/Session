import QtQuick 2.0
import Felgo 3.0

Item {

    id: dataModel

    property var inboxJson: [{}]
    property var notificationJson: [{}]
    property var feedJson: [{}]   
    property var userDataJson: [{
            firstname: "Katie",
            surname: "Prescott",
            email: "katherineprescott@live.co.uk",
            publicUID: "KatiePrescottHair",
            role: "Hairstylist",
            location: "London",
            lastActive: "",
            experience: "Highly Experienced",
            details: [{}],
            tfpStatus: "",
            specialities: ["Avant Garde", "Catwalk", "Fashion"],
            bio: "",
            portfolio: [{}],
            feed: [{}]
        }]
    property var savedForLaterJson: [{}]
    property var myShootsJson: [
        {"e1234567890": {
                eventCreator: "u1234",
                eventName: "Katie's BHA",
                eventDate: "1653053810",
                eventTime: "08:00",
                keyContacts: ["u1234", "u3456"],
                overview: "We're working on my 2021 BHA avant garde shoot! looking for organic textures and bright colours as shown in moodboards! This will be a super fun day so bring lots of energy!",
                coverImage: "",
                moodboard: ["","",""],
                locationAddress: "Flat 59, Basque Court, Garter Way, London, SE16 6XD",
                locationMap: "51.477928, -0.001545",

                "team": [{id: "u1234", name: "Katie", role: "hairstylist"},{id: "u2345", name: "Edward", role: "model"},{id: "u3456", name: "Jo", role: "hairstylist"},{id: "u4567", name: "Julie", role: "Photographer"}]
            }
        },
        {"e1234567892": {
                eventCreator: "u2345",
                eventName: "Jo's BHA",
                eventDate: "1653053810",
                eventTime: "14:00",
                keyContacts: ["u1234", "u3456"],
                overview: "We're working on my 2021 BHA avant garde shoot! looking for organic textures and bright colours as shown in moodboards! This will be a super fun day so bring lots of energy!",
                coverImage: "",
                moodboard: ["","",""],
                locationAddress: "Flat 59, Basque Court, Garter Way, London, SE16 6XD",
                locationMap: "51.477928, -0.001545",

                "team": [{id: "u1234", name: "Katie", role: "hairstylist"},{id: "u2345", name: "Edward", role: "model"},{id: "u3456", name: "Jo", role: "hairstylist"},{id: "u4567", name: "Julie", role: "Photographer"}]
            }
        },
        {"e1234567893": {
                eventCreator: "u1234",
                eventName: "Katie's FAME Finale",
                eventDate: "1653053810",
                eventTime: "08:00",
                keyContacts: ["u1234", "u3456"],
                overview: "We're working on my 2021 BHA avant garde shoot! looking for organic textures and bright colours as shown in moodboards! This will be a super fun day so bring lots of energy!",
                coverImage: "",
                moodboard: ["","",""],
                locationAddress: "Flat 59, Basque Court, Garter Way, London, SE16 6XD",
                locationMap: "51.477928, -0.001545",

                "team": [{id: "u1234", name: "Katie", role: "hairstylist"},{id: "u2345", name: "Edward", role: "model"},{id: "u3456", name: "Jo", role: "hairstylist"},{id: "u4567", name: "Julie", role: "Photographer"}]
            }
        }
    ]


}
