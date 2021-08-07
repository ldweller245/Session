import QtQuick 2.0
import Felgo 3.0
import "../Plugins"

Item {
    id: dataModel

    signal nameAvailable

    property var remoteFilePath
    property var uuid
    property var rrole; property var rgender; property var rfirstname; property var rsurname; property var rusername; property var remail; property var rpassword; property var rbaseLocation; property var rexperience; property var rtfp; property var rspecialities; property var rage; property var rheightCM; property var rethnicity; property var rhairColor; property var rhairLength; property var rskinColor; property var reyeColor; property var rshoeSize; property var rwaist; property var rhips; property var rinseam; property var rsuitSize; property var rtattoo; property var rpiercing; property var rprofileImagePath; property var rbio; property var rbust; property var rdressSize
    property var regDetails: []


    function uniqueID() {
        return Math.floor(Math.random() * Math.floor(Math.random() * Date.now()))
    }

    FirebaseConfig {id: firebaseConfig; storageBucket: "session-10d53.appspot.com";  projectId: "session-10d53"; databaseUrl: "https://session-10d53-default-rtdb.europe-west1.firebasedatabase.app/"; apiKey: Qt.platform.os === "android" ? "AIzaSyClEiWZ5tOnHpB0kl19W4guYMZXBw5k6Hw": "AIzaSyCWy_CbVSdDFJGwtTvhiNJYtK3VA6Ehj4Q"; applicationId:  Qt.platform.os === "android" ? "1:627724626656:android:74443461c4df304ccc7e85": "1:627724626656:ios:1a1ec445bbaf1efbcc7e85"}

    FirebaseDatabase {
        id: db; config: firebaseConfig; onReadCompleted: {if(success) {console.debug("Read value " +  JSON.stringify(value) + " for key " + key)}else {console.debug("Error with message: "  + value)}}
        onWriteCompleted: {if(success) {console.debug("Successfully wrote to DB")}else {console.debug("Write failed with error: " + message)}}
        realtimeValueKeys: []; onRealtimeValueChanged: { }
        onFirebaseReady: {
            //remember to delete
            //remember to delete
            //remember to delete
            firebaseAuth.logoutUser()
            //remember to delete
            //remember to delete
            //remember to delete

            db.getValue("public/received", {function(success, key, value) {if(success) {console.log("<br><br><br><br>Read value for key", key, "from DB:", JSON.stringify(value) +"<br><br><br>")}}})
            db.setValue("public/myObject", {keyA: 17, keyB: "this is my DB object"},function(success, message) {if(success) {console.log("successfully written object to DB")}else {console.log("DB write error:", message)}})
        }
    }

    FirebaseAuth {id: firebaseAuth; config: firebaseConfig;
        onUserRegistered: {
            if(!success) {nativeUtils.displayMessageBox(qsTr("Somethings gone wrong!"), qsTr("Seems like: %1").arg(message), 1)}
            else {
                storage.uploadFile(rprofileImagePath, uuid + Date.now() + ".png", function(progress, finished, success, downloadUrl) {
                    if(!finished) {
                        //status.text = "Uploading... " + progress.toFixed(2) + "%"
                    } else if (finished && success) {remoteFilePath = downloadUrl; db.setUserValue("details", regDetails); db.setUserValue("details/profile_Pic_URL", remoteFilePath); db.setValue("userData/"+uuid+"/profile_Pic_URL", remoteFilePath); registerPage.visible = false; loginPage.visible = false}
                })
            }
        }
        onLoggedIn: {
            db.getUserValue("details", {
                                //startAt: searchKey,      //return only keys alphabetically after "x"
                                //return only keys alphabetically before "x"
                            }, function(success, key, value) {
                                if(success) {userData = []; userData = value; console.debug("JSON VALUE: <br><br><br>" + JSON.stringify(userData))}
                            })
            console.debug("User login " + success + " - " + message);
            if(success) {registerPage.visible = false; loginPage.visible = false}
        }
    }


    FirebaseStorage {
        id: storage
        config: firebaseConfig
    }

    property var inboxJson: [{}]
    property var notificationJson: [{}]
    property var postJson: []
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
    property var otherUserJson: {
        1: {
            "id": 1, //userID
            "firstname": "Jo",
            "surname": "Brown",
            "profile_Pic_URL": "data:image/jpeg;base64,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",
            "email": "JoBrown@live.co.uk",
            "username": "JoBrownLondon",
            "role": "Hairstylist", //Hair, Clothes, Location
            "bio": "", //userBIO
            "location": "Essex, UK",
            "lastActive": 1590527342000,
            "experience": "Highly Experienced",
            "tfpStatus": "",
            "portfolio": [{}],
            "blocked_by_user": false,
            "has_blocked_user": false,
            "followed_by_user": true,
            "follows_user": true,
            "measurements": [
                {"height": "180cm"},
                {"shoe": "8"},
                {"waist": "32"},
                {"hair": "brown"},
                {"eye": "blue"}
            ],
            "specialities": ["Fashion", "Film", "Editorial"],
            "feed_count": 9,
            "feed_posts": {
                "p1": {//postID
                    "id": "p1",
                    "dimensions":{
                        "height":1139,
                        "width":1080
                    },
                    "display_url":"https://static.wixstatic.com/media/d26481_e9ace1093c0444cf9749e534c0672272~mv2.jpeg/v1/fill/w_567,h_851,al_c,q_85,usm_0.66_1.00_0.01/d26481_e9ace1093c0444cf9749e534c0672272~mv2.webp", //post Image URL
                    "owner":{
                        "id":"1",
                        "username":"JoBrownLondon"
                    },
                    "post_description" : "", //post Description
                    "timestamp":1603320528,
                    "team": {
                    },
                    "liked_by":{
                        "count":0
                    },
                    "location":"null",
                    "thumbnail_src":"https://static.wixstatic.com/media/d26481_e9ace1093c0444cf9749e534c0672272~mv2.jpeg/v1/fill/w_567,h_851,al_c,q_85,usm_0.66_1.00_0.01/d26481_e9ace1093c0444cf9749e534c0672272~mv2.webp",
                },
                "p2": {//postID
                    "id": "p2",
                    "dimensions":{
                        "height":1139,
                        "width":1080
                    },
                    "display_url":"https://static.wixstatic.com/media/d26481_e9ace1093c0444cf9749e534c0672272~mv2.jpeg/v1/fill/w_567,h_851,al_c,q_85,usm_0.66_1.00_0.01/d26481_e9ace1093c0444cf9749e534c0672272~mv2.webp", //post Image URL
                    "owner":{
                        "id":"1",
                        "username":"JoBrownLondon"
                    },
                    "post_description" : "", //post Description
                    "timestamp":1603320529,
                    "team": {
                    },
                    "liked_by":{
                        "count":0
                    },
                    "location":null,
                    "thumbnail_src":"",
                },
                "p3": {//postID
                    "id": "p3",
                    "dimensions":{
                        "height":1139,
                        "width":1080
                    },
                    "display_url":"https://static.wixstatic.com/media/d26481_57a2802e01c14e63bcc7989920cb5b98~mv2.jpg/v1/fill/w_603,h_851,al_c,q_85,usm_0.66_1.00_0.01/d26481_57a2802e01c14e63bcc7989920cb5b98~mv2.webp", //post Image URL
                    "owner":{
                        "id":"1",
                        "username":"JoBrownLondon"
                    },
                    "post_description" : "", //post Description
                    "timestamp":1603320530,
                    "team": {
                    },
                    "liked_by":{
                        "count":0
                    },
                    "location":null,
                    "thumbnail_src":"",
                },
                "p4": {//postID
                    "id": "p4",
                    "dimensions":{
                        "height":1139,
                        "width":1080
                    },
                    "display_url":"https://static.wixstatic.com/media/d26481_c007fb8760804d569dff3f2c491c928b~mv2.jpg/v1/fill/w_506,h_674,al_c,lg_1,q_80/d26481_c007fb8760804d569dff3f2c491c928b~mv2.webp", //post Image URL
                    "owner":{
                        "id":"1",
                        "username":"JoBrownLondon"
                    },
                    "post_description" : "", //post Description
                    "timestamp":1603320531,
                    "team": {
                    },
                    "liked_by":{
                        "count":0
                    },
                    "location":null,
                    "thumbnail_src":"",
                },
                "p5": {//postID
                    "id": "p5",
                    "dimensions":{
                        "height":1139,
                        "width":1080
                    },
                    "display_url":"https://static.wixstatic.com/media/d26481_c007fb8760804d569dff3f2c491c928b~mv2.jpg/v1/fill/w_506,h_674,al_c,lg_1,q_80/d26481_c007fb8760804d569dff3f2c491c928b~mv2.webp", //post Image URL
                    "owner":{
                        "id":"1",
                        "username":"JoBrownLondon"
                    },
                    "post_description" : "", //post Description
                    "timestamp":1603320532,
                    "team": {
                    },
                    "liked_by":{
                        "count":0
                    },
                    "location":null,
                    "thumbnail_src":"",
                },
                "p6": {//postID
                    "id": "p6",
                    "dimensions":{
                        "height":1139,
                        "width":1080
                    },
                    "display_url":"https://static.wixstatic.com/media/d26481_bb1fd69592d442d38d6893a3ad95aa31~mv2.jpg/v1/fill/w_445,h_674,al_c,lg_1,q_80/d26481_bb1fd69592d442d38d6893a3ad95aa31~mv2.webp", //post Image URL
                    "owner":{
                        "id":"1",
                        "username":"JoBrownLondon"
                    },
                    "post_description" : "", //post Description
                    "timestamp":1603320533,
                    "team": {
                    },
                    "liked_by":{
                        "count":0
                    },
                    "location":null,
                    "thumbnail_src":"",
                },
                "p7": {//postID
                    "id": "p7",
                    "dimensions":{
                        "height":1139,
                        "width":1080
                    },
                    "display_url":"https://static.wixstatic.com/media/d26481_bb1fd69592d442d38d6893a3ad95aa31~mv2.jpg/v1/fill/w_445,h_674,al_c,lg_1,q_80/d26481_bb1fd69592d442d38d6893a3ad95aa31~mv2.webp", //post Image URL
                    "owner":{
                        "id":"1",
                        "username":"JoBrownLondon"
                    },
                    "post_description" : "", //post Description
                    "timestamp":1603320534,
                    "team": {
                    },
                    "liked_by":{
                        "count":0
                    },
                    "location":null,
                    "thumbnail_src":"",
                },
                "p8": {//postID
                    "id": "p8",
                    "dimensions":{
                        "height":1139,
                        "width":1080
                    },
                    "display_url":"https://static.wixstatic.com/media/d26481_fde2922024c84e7a817a5a19cfbf096f~mv2.jpg/v1/fill/w_446,h_674,al_c,lg_1,q_80/d26481_fde2922024c84e7a817a5a19cfbf096f~mv2.webp", //post Image URL
                    "owner":{
                        "id":"1",
                        "username":"JoBrownLondon"
                    },
                    "post_description" : "", //post Description
                    "timestamp":1603320535,
                    "team": {
                    },
                    "liked_by":{
                        "count":0
                    },
                    "location":null,
                    "thumbnail_src":"",
                },
                "p9": {//postID
                    "id": "p9",
                    "dimensions":{
                        "height":1139,
                        "width":1080
                    },
                    "display_url":"https://static.wixstatic.com/media/d26481_e2ce8706db0d4bd3b24f90278294f3b0~mv2.jpg/v1/fill/w_466,h_674,al_c,lg_1,q_80/d26481_e2ce8706db0d4bd3b24f90278294f3b0~mv2.webp", //post Image URL
                    "owner":{
                        "id":"1",
                        "username":"JoBrownLondon"
                    },
                    "post_description" : "", //post Description
                    "timestamp":1603320536,
                    "team": {
                    },
                    "liked_by":{
                        "count":0
                    },
                    "location":null,
                    "thumbnail_src":""
                }
            }
        }
    }
    property var discover_hair: [
        {
            987654322: {//postID
                "id": 987654322,
                "dimensions":{
                    "height":1139,
                    "width":1080
                }, //jo
                "display_url":"https://static.wixstatic.com/media/d26481_25526c9b62364d93951d69c2f236ed1c~mv2.jpg/v1/fill/w_567,h_851,al_c,q_85,usm_0.66_1.00_0.01/d26481_25526c9b62364d93951d69c2f236ed1c~mv2.webp", //post Image URL
                "owner":{
                    "id":"12345",
                    "username":"Jo Brown"
                },
                "post_description" : "", //post Description
                "timestamp":1603320528,
                "team": {
                },
                "liked_by":{
                    "count":1007
                },
                "location":null,
                "thumbnail_src":"",
            },
            987654323: {//postID
                "id": 987654323,
                "dimensions":{
                    "height":1139,
                    "width":1080
                }, //jo
                "display_url":"https://static.wixstatic.com/media/d26481_bb1fd69592d442d38d6893a3ad95aa31~mv2.jpg/v1/fill/w_445,h_674,al_c,lg_1,q_80/d26481_bb1fd69592d442d38d6893a3ad95aa31~mv2.webp", //post Image URL
                "owner":{
                    "id":"12345",
                    "username":"Jo Brown"
                },
                "post_description" : "", //post Description
                "timestamp":1603320528,
                "team": {
                },
                "liked_by":{
                    "count":0
                },
                "location":null,
                "thumbnail_src":"",
            },

            987654324: {//postID
                "id": 987654324,
                "dimensions":{
                    "height":1139,
                    "width":1080
                },//tracey
                "display_url":"https://static.wixstatic.com/media/d26481_c7c804e594cb40fcb8dec064e1270190~mv2.jpeg/v1/fill/w_906,h_605,al_c,q_85,usm_0.66_1.00_0.01/d26481_c7c804e594cb40fcb8dec064e1270190~mv2.webp", //post Image URL
                "owner":{
                    "id":"23456",
                    "username":"Tracey Sweeting"
                },
                "post_description" : "", //post Description
                "timestamp":1603320528,
                "team": {
                },
                "liked_by":{
                    "count":2
                },
                "location":null,
                "thumbnail_src":"",
            },

            987654325: {//postID
                "id": 987654325,
                "dimensions":{
                    "height":1139,
                    "width":1080
                }, //jo
                "display_url":"https://static.wixstatic.com/media/d26481_af5c7d8a27144299a91aaeb197693325~mv2.jpeg/v1/fill/w_567,h_851,al_c,q_85,usm_0.66_1.00_0.01/d26481_af5c7d8a27144299a91aaeb197693325~mv2.webp", //post Image URL
                "owner":{
                    "id":"12345",
                    "username":"Jo Brown"
                },
                "post_description" : "", //post Description
                "timestamp":1603320528,
                "team": {
                },
                "liked_by":{
                    "count":107
                },
                "location":null,
                "thumbnail_src":"",
            },

            987654326: {//postID
                "id": 987654326,
                "dimensions":{
                    "height":1139,
                    "width":1080
                },//joseph
                "display_url":"https://static.wixstatic.com/media/d26481_33ec3ee774124acdac5a8297fb7b9450~mv2.jpg/v1/fill/w_662,h_827,al_c,q_85,usm_0.66_1.00_0.01/d26481_33ec3ee774124acdac5a8297fb7b9450~mv2.webp", //post Image URL
                "owner":{
                    "id":"34567",
                    "username":"Joseph"
                },
                "post_description" : "", //post Description
                "timestamp":1603320528,
                "team": {
                },
                "liked_by":{
                    "count":52
                },
                "location":null,
                "thumbnail_src":"",
            }
        }
    ]
    property var discover_makeup: {
    }
    property var discover_clothes: {
    }
    property var discover_photographers: {
    }
    property var discover_models: {

    }
    property var discover_locations: {
    }


    function registerUser(role, gender, firstname, surname, username, email, password, baseLocation, experience, tfp, specialities, age, heightCM, ethnicity, hairColor, hairLength, skinColor, eyeColor, shoeSize, waist, hips, inseam, suitSize, tattoo, piercing,  profileImagePath, bio,bust, dressSize) {
        firebaseAuth.logoutUser()
        uuid = uniqueID()
        rrole = role
        rgender = gender
        rfirstname = firstname
        rsurname = surname
        rusername = username
        remail = email
        rpassword = password
        rbaseLocation = baseLocation
        rexperience = experience
        rtfp = tfp
        rspecialities = specialities
        rage = age
        rheightCM = heightCM
        rethnicity = ethnicity
        rhairColor = hairColor
        rhairLength = hairLength
        rskinColor = skinColor
        reyeColor = eyeColor
        rshoeSize = shoeSize
        rwaist = waist
        rhips = hips
        rinseam = inseam
        rsuitSize = suitSize
        rtattoo = tattoo
        rpiercing = piercing
        rprofileImagePath = profileImagePath
        rbio = bio
        rbust = bust
        rdressSize = dressSize
        remoteFilePath = profileImagePath

        if(role === "Model") {
            if(gender === "Male"){
                regDetails = ({"id": uuid,
                                  "role": rrole,
                                  "gender": rgender,
                                  "firstname": rfirstname,
                                  "surname": rsurname,
                                  "username": rusername,
                                  "email": remail,
                                  "location": rbaseLocation,
                                  "specialities": rspecialities,
                                  "profile_Pic_URL": remoteFilePath,
                                  "bio": rbio,
                                  "lastActive": new Date().getTime(),
                                  "blocked_by_user": false,
                                  "has_blocked_user": false,
                                  "followed_by_user": true,
                                  "follows_user": true,
                                  "feed_count": 0,
                                  "measurements": {
                                      "experience": rexperience,
                                      "tfpStatus": rtfp,
                                      "age": rage,
                                      "heightCM": rheightCM,
                                      "ethnicity": rethnicity,
                                      "hairColor": rhairColor,
                                      "hairLength": rhairLength,
                                      "skinColor": rskinColor,
                                      "eyeColor": reyeColor,
                                      "shoeSize": rshoeSize,
                                      "waist": rwaist,
                                      "inseam": rinseam,
                                      "suitSize": rsuitSize,
                                      "piercing": rpiercing,
                                      "tattoo": rtattoo
                                  }

                              })
            }else if(gender === "Female") {
                regDetails = ({"id": uuid,
                                  "role": rrole,
                                  "gender": rgender,
                                  "firstname": rfirstname,
                                  "surname": rsurname,
                                  "username": rusername,
                                  "email": remail,
                                  "location": rbaseLocation,
                                  "specialities": rspecialities,
                                  "profile_Pic_URL": remoteFilePath,
                                  "bio": rbio,
                                  "lastActive": new Date().getTime(),
                                  "blocked_by_user": false,
                                  "has_blocked_user": false,
                                  "followed_by_user": true,
                                  "follows_user": true,
                                  "feed_count": 0,
                                  "measurements": {
                                      "experience": rexperience,
                                      "tfpStatus": rtfp,
                                      "age": rage,
                                      "heightCM": rheightCM,
                                      "ethnicity": rethnicity,
                                      "hairColor": rhairColor,
                                      "hairLength": rhairLength,
                                      "skinColor": rskinColor,
                                      "eyeColor": reyeColor,
                                      "shoeSize": rshoeSize,
                                      "waist": rwaist,
                                      "hips": rhips,
                                      "piercing": rpiercing,
                                      "tattoo": rtattoo
                                  }
                              })

            }else {
                regDetails = ({"id": uuid,
                                  "role": rrole,
                                  "firstname": rfirstname,
                                  "surname": rsurname,
                                  "username": rusername,
                                  "email": remail,
                                  "location": rbaseLocation,
                                  "specialities": rspecialities,
                                  "profile_Pic_URL": remoteFilePath,
                                  "bio": rbio,
                                  "lastActive": new Date().getTime(),
                                  "blocked_by_user": false,
                                  "has_blocked_user": false,
                                  "followed_by_user": true,
                                  "follows_user": true,
                                  "feed_count": 0,
                                  "measurements": {
                                      "gender": rgender,
                                      "experience": rexperience,
                                      "tfpStatus": rtfp,
                                      "age": rage,
                                      "heightCM": rheightCM,
                                      "ethnicity": rethnicity,
                                      "hairColor": rhairColor,
                                      "hairLength": rhairLength,
                                      "skinColor": rskinColor,
                                      "eyeColor": reyeColor,
                                      "shoeSize": rshoeSize,
                                      "waist": rwaist,
                                      "hips": rhips,
                                      "inseam": rinseam,
                                      "suitSize": rsuitSize,
                                      "piercing": rpiercing,
                                      "tattoo": rtattoo
                                  }
                              })

            }
        } else {
            regDetails = ({"id": uuid,
                              "role": rrole,
                              "gender": rgender,
                              "firstname": rfirstname,
                              "surname": rsurname,
                              "username": rusername,
                              "email": remail,
                              "location": rbaseLocation,
                              "specialities": rspecialities,
                              "profile_Pic_URL": remoteFilePath,
                              "bio": rbio,
                              "lastActive": new Date().getTime(),
                              "blocked_by_user": false,
                              "has_blocked_user": false,
                              "followed_by_user": true,
                              "follows_user": true,
                              "feed_count": 0,
                              "measurements": {
                                  "experience": rexperience,
                                  "tfpStatus": rtfp,
                              }
                          })

        }
        db.setValue("userData/"+uuid, regDetails)
        firebaseAuth.registerUser(email, password)
    }
    function loginUser(email, password) {
        firebaseAuth.loginUser(email, password)
        updateFeed()
    }
    function logoutUser() {
        firebaseAuth.logoutUser()
        console.log("logged out")
        registerPage.visible = true
        loginPage.visible = true
    }
    function updateFeed() {
        /*
        db.getValue("public/received", {
                        function(success, key, value) {
                            if(success) {
                                console.log("Read value for key", key, "from DB:", JSON.stringify(value) +"<br><br><br>")
                            }
                        }
                    })
        */
    }
    function createPost(postImagePath, img_height, img_width, post_description, team, location, tag) {
        let updateFeedCount = userData.feed_count +1
        let postID = uniqueID()

        //need to set to userData/feed_posts
        //need to set to userData/feed_posts
        //need to set to userData/feed_posts
        //need to set to userData/feed_posts
        //need to set to userData/feed_posts
        //need to set to userData/feed_posts

        storage.uploadFile(postImagePath, userData.id + Date.now() + ".png", function(progress, finished, success, downloadUrl) {
            if(!finished) {} else if (finished && success) {
                db.setUserValue("feed_count", updateFeedCount)
                db.setUserValue("feed_posts/p-uid"+postID+"/", {
                                    "id": "p-uid"+postID,
                                    "dimensions":{
                                        "height":img_height,
                                        "width":img_width
                                    },
                                    "display_url":"", downloadUrl,
                                    "owner":{
                                        "id": userData.id,
                                        "username": userData.username
                                    },
                                    "post_description" : post_description,
                                    "timestamp": Date.now(),
                                    "team": {
                                        "hair": [
                                            {"id": 123, "name": "JoBrownLondon"},
                                            {"id": 321, "name": "KatiePrescott"}
                                        ],
                                        "makeup": [
                                            {"id": 456, "name": "SadieLauder"}
                                        ],
                                        "model": [
                                            {"id": 654, "name": "EdwardLawrence"}
                                        ]
                                    },
                                    "liked_by":{
                                        "count":0,
                                        "liked_by_me": true

                                    },
                                    "tag": tag,
                                    "location": location})
            }
        })

    }
    function editPost(postID, post_description, team, location, tag) {
        db.setUserValue("feed_posts/p-uid"+postID+"/", {
                            "post_description" : post_description,
                            "team": {
                            },
                            "location": location,
                            "tag": tag})
    }
    function deletePost(postID) {
        let updateFeedCount = userData.feed_count -1
        db.setUserValue(postID, null)
        db.setUserValue("feed_count", updateFeedCount)
    }
    function likePost(postID) {
        let likeCount
        let liked_by_me_value
        db.getUserValue(/*posts/postID/likecount*/)
        //success,key, value; liked_by_me === true ? likeCount = likeCount -1 && liked_by_me_value = false : likeCount = likeCount +1 && liked_by_me_value = false
        db.setUserValue(/*set like count && liked_by_me_value */)
    }

    function createEvent() {

    }
    function getEvent() {

    }
    function searchUsers() {

    }
    function getUser() {

    }
    function getFeed() {

    }
    function addToNameList(id, userName) {
        db.setValue("public/nameList/"+userName, id)
    }
    function checkUsernameAvailability(name) {
        let searchKey = name.charAt(0)
        db.getValue("public/nameList/"+name, {
                        //startAt: searchKey,      //return only keys alphabetically after "x"
                        //return only keys alphabetically before "x"
                    }, function(success, key, value) {
                        if(success) {nativeUtils.displayMessageBox(qsTr("Try Again!"), qsTr("Username already exists"))}
                        else {dataModel.nameAvailable()}
                    })
    }
}
