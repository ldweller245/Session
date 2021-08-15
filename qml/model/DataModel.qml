import QtQuick 2.0
import Felgo 3.0
import "../Plugins"

Item {
    id: dataModel

    /*
    DATAMODEL STORAGE PLANS
    branch 1 - userData
        public branch containing the userdata of all inidvidual profiles, organised by uuid then name/details/portfolio ect

    branch 2 - master feed
        contains ALL posts, ever.
        also useful for the 'explore' page, cycling through the most recent X entries to populate

    branch 3 - user feeds
        when a user posts to the master feed, it will circulate down to all their followers via this
        organised by uuid then all feed items

    branch 4 - chats
        chatID followed by chat content and those who can access it?

    */

    signal nameAvailable

    property var remoteFilePath
    property var uuid
    property var rrole; property var rgender; property var rfirstname; property var rsurname; property var rusername; property var remail; property var rpassword; property var rbaseLocation; property var rexperience; property var rtfp; property var rspecialities; property var rage; property var rheightCM; property var rethnicity; property var rhairColor; property var rhairLength; property var rskinColor; property var reyeColor; property var rshoeSize; property var rwaist; property var rhips; property var rinseam; property var rsuitSize; property var rtattoo; property var rpiercing; property var rprofileImagePath; property var rbio; property var rbust; property var rdressSize
    property var regDetails: []
    property var regUserDetails: []
    property var otherUserData

    property var userID: userData.id

    readonly property string realtimeUserData: "userData/" + userData.id
    readonly property string realtimeMasterFeed: "masterFeed/"
    readonly property string realtimeUserFeed: "userFeeds/" + userData.id
    readonly property string realtimeChats: "chats/"

    /*Timer {
        interval: 60000; running: true; repeat: true
        onTriggered: getMasterFeed()
    }*/

    function uniqueID() {
        return Math.floor(Math.random() * Math.floor(Math.random() * Date.now()))
    }
    FirebaseConfig {id: firebaseConfig; storageBucket: "session-10d53.appspot.com";  projectId: "session-10d53"; databaseUrl: "https://session-10d53-default-rtdb.europe-west1.firebasedatabase.app/"; apiKey: Qt.platform.os === "android" ? "AIzaSyClEiWZ5tOnHpB0kl19W4guYMZXBw5k6Hw": "AIzaSyCWy_CbVSdDFJGwtTvhiNJYtK3VA6Ehj4Q"; applicationId:  Qt.platform.os === "android" ? "1:627724626656:android:74443461c4df304ccc7e85": "1:627724626656:ios:1a1ec445bbaf1efbcc7e85"}

    FirebaseDatabase {
        id: db; config: firebaseConfig; onReadCompleted: {if(success) {console.debug("Read value " +  JSON.stringify(value) + " for key " + key)}else {console.debug("Error with message: "  + value)}}
        onWriteCompleted: {if(success) {console.debug("Successfully wrote to DB")}else {console.debug("Write failed with error: " + message)}}
        realtimeValueKeys: [realtimeUserData];
        onRealtimeValueChanged: {
            if(key === realtimeUserData) {
                console.log("REALTIMEUSERUPDATE")
                userData = []; userData = value
            }
            else if(key === realtimeMasterFeed) {
                masterFeed = []; masterFeed = value}
            else if(key === realtimeChats) {}
            else if(key === realtimeUserFeed) {
                userFeed = value
            }
        }
        onFirebaseReady: {
            //remember to delete
            //remember to delete
            //remember to delete
            firebaseAuth.logoutUser()
            //remember to delete
            //remember to delete
            //remember to delete
        }
    }

    FirebaseAuth {id: firebaseAuth; config: firebaseConfig;
        onUserRegistered: {
            if(!success) {nativeUtils.displayMessageBox(qsTr("Somethings gone wrong!"), qsTr("Seems like: %1").arg(message), 1)}
            else {
                storage.uploadFile(rprofileImagePath, "images/"+uuid + Date.now() + ".png", function(progress, finished, success, downloadUrl) {
                    if(!finished) {
                    } else if (finished && success) {remoteFilePath = downloadUrl; addToNameList(uuid, rusername) ; db.setUserValue("details", regUserDetails); db.setValue("userData/"+uuid+"/profile_Pic_URL", remoteFilePath); userData = regDetails; registerPage.visible = false; loginPage.visible = false}
                })
            }
            getMasterFeed()
        }
        onLoggedIn: {
            userData = [];
            db.getUserValue("details/id", {
                            }, function(success, key, value) {
                                if(success) {
                                    db.getValue("userData/"+value, {}, function(success, key, value){
                                        if(success){
                                            userData = value
                                            console.debug("USERDATA: "+ JSON.stringify(userData))

                                        }
                                    })
                                    db.setValue("userData/"+value+"/lastActive", Date.now())
                                }
                            })
            getMasterFeed()
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
            "profile_Pic_URL": "",
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
            }
        }
    ]

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
                                  "feedCount": 0,
                                  "followers": {
                                      "follower_count": 0,
                                      "follower_list": {}
                                  },
                                  "follows": {
                                      "follow_count": 0,
                                      "follow_list": {}
                                  },
                                  "measurements": {
                                      "Experience": rexperience,
                                      "TFP": rtfp,
                                      "Age": rage,
                                      "Height": rheightCM,
                                      "Ethnicity": rethnicity,
                                      "Hair Color": rhairColor,
                                      "Hair Length": rhairLength,
                                      "Skin": rskinColor,
                                      "Eyes": reyeColor,
                                      "Shoe": rshoeSize,
                                      "Waist": rwaist,
                                      "Inseam": rinseam,
                                      "Suit": rsuitSize,
                                      "Piercings": rpiercing,
                                      "Tattoos": rtattoo
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
                                  "feedCount": 0,
                                  "followers": {
                                      "follower_count": 0,
                                      "follower_list": {}
                                  },
                                  "follows": {
                                      "follow_count": 0,
                                      "follow_list": {}
                                  },
                                  "measurements": {
                                      "Experience": rexperience,
                                      "TFP": rtfp,
                                      "Age": rage,
                                      "Height": rheightCM,
                                      "Ethnicity": rethnicity,
                                      "Hair Color": rhairColor,
                                      "Hair Length": rhairLength,
                                      "Skin": rskinColor,
                                      "Eyes": reyeColor,
                                      "Shoe": rshoeSize,
                                      "Waist": rwaist,
                                      "Hips": rhips,
                                      "Bust": rbust,
                                      "Dress": rdressSize,
                                      "Piercings": rpiercing,
                                      "Tattoos": rtattoo
                                  }
                              })

            }else {
                regDetails = ({"id": uuid,
                                  "role": rrole,
                                  "firstname": rfirstname,
                                  "surname": rsurname,
                                  "username": rusername,
                                  "gender": rgender,
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
                                  "feedCount": 0,
                                  "followers": {
                                      "follower_count": 0,
                                      "follower_list": {}
                                  },
                                  "follows": {
                                      "follow_count": 0,
                                      "follow_list": {}
                                  },
                                  "measurements": {
                                      "Experience": rexperience,
                                      "TFP": rtfp,
                                      "Age": rage,
                                      "Height": rheightCM,
                                      "Ethnicity": rethnicity,
                                      "Hair Color": rhairColor,
                                      "Hair Length": rhairLength,
                                      "Skin": rskinColor,
                                      "Eyes": reyeColor,
                                      "Shoe": rshoeSize,
                                      "Waist": rwaist,
                                      "Hips": rhips,
                                      "Inseam": rinseam,
                                      "Suit": rsuitSize,
                                      "Bust": rbust,
                                      "Dress": rdressSize,
                                      "Piercings": rpiercing,
                                      "Tattoos": rtattoo
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
                              "feedCount": 0,
                              "followers": {
                                  "follower_count": 0,
                                  "follower_list": {}
                              },
                              "follows": {
                                  "follow_count": 0,
                                  "follow_list": {}
                              },
                              "measurements": {
                                  "Experience": rexperience,
                                  "TFP": rtfp,
                              }
                          })

        }
        regUserDetails = {
            "id": uuid,
            "role": rrole,
            "firstname": rfirstname,
            "surname": rsurname,
            "username": rusername,
            "email": remail
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
    function resetPassword(email) {
        firebaseAuth.sendPasswordResetMail(email)
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
        let updateFeedCount = userData.feedCount +1
        let postID = "p-uid"+uniqueID()

        storage.uploadFile(postImagePath, "images/"+userData.id + Date.now() + ".png", function(progress, finished, success, downloadUrl) {
            if(!finished) {} else if (finished && success) {
                db.setValue("userData/"+ userData.id+"/feedCount/", updateFeedCount)
                let userPost = {
                    "id": postID,
                    "dimensions":{
                        "height":img_height,
                        "width":img_width
                    },
                    "downloadUrl": downloadUrl,
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
                        "liked_by_me": false
                    },
                    "tag": tag,
                    "location": location
                }
                db.setValue("masterFeed/"+postID, userPost)
                db.setValue("userData/"+userData.id+"/feed_posts/"+postID, userPost)
                fanPosts(userData.id, userPost, postID)
            }
        })
    }
    function editPost(postID, post_description, team, location, tag) {
        db.setValue("userData/"+uuid+"feed_posts/"+postID+"/", {
                        "post_description" : post_description,
                        "team": {
                        },
                        "location": location,
                        "tag": tag})
    }
    function deletePost(postID) {
        let updateFeedCount = userData.feedCount -1
        db.setUserValue(postID, null)
        db.setUserValue("feedCount", updateFeedCount)
    }
    function likePost(postID) {
        let likeCount
        let liked_by_me_value
        db.getUserValue(/*posts/postID/likecount*/)
        //success,key, value; liked_by_me === true ? likeCount = likeCount -1 && liked_by_me_value = false : likeCount = likeCount +1 && liked_by_me_value = false
        db.setUserValue(/*set like count && liked_by_me_value */)
    }
    function createEvent(event_name, event_organiser, event_date, event_time, event_overview, cover_image, event_concept, event_location, event_team) {
        let eventID = "e-uid"+uniqueID()

        /*events/e-uid"+eventID*/
        let eventData =  {
            "eventCreator": {
                "name": userData.name,
                "id": userData.id
            },
            "eventName": event_name,
            "eventDate": event_date,
            "eventTime": event_time,
            "keyContacts": {
                "name": userData.name,"id": userData.id,
                "name2": userData.name,"id2": userData.id
                //other User{"name": "userData.name,"id": "userData.id"}
            },
            "overview": event_overview,
            "coverImage": cover_image,
            "moodboard": ["","",""],
            "location": {
                "address": "",//address
                "map": "51.477928, -0.001545"
            },
            "team": [
                {"id": "u1234", "name": "Katie", "role": "hairstylist"},
                {"id": "u2345", "name": "Edward", "role": "model"},
                {"id": "u3456", "name": "Jo", "role": "hairstylist"},
                {"id": "u4567", "name": "Julie", "role": "Photographer"}
            ]
        }
        db.setValue("userData/"+uuid+"/"+eventID, eventData)
    }
    function getEvent(eventID) {
        db.getValue(/*events*/)

    }
    function searchUsers(searchString) {
        console.log("Search String: "+ searchString)
        db.getValue("public/nameList", {

                        orderByKeys: true,
                        //startAt: JSON.stringify(searchString),
                        //endAt: JSON.stringify(searchString) + "~",
                        limitToFirst: 3

                    }, function(success, key, value) {
                        if(success) {
                            console.log("nameList: " + Object.keys(value))
                            searchArr = []
                            searchArr = value
                            console.debug("searchArr: "+JSON.stringify(searchArr))
                        }
                    })
    }
    function getUser(userID, username) {
        db.getValue("userData/"+userID, {function(success, key, value) {if(success) {otherUserData = value}}})
    }
    function getFeed() {
        db.getValue("feeds/"+uuid)
    }
    function getMasterFeed() {
        db.getValue("masterFeed/", {
                        //orderByKeys: true,  //order by key before limiting
                        //limitToFirst: 100,   //return only first 5 sub-keys
                    }, function(success, key, value) {
                        if(success) {                            
                            masterFeed = value
                            console.log("MASTER FEED: <br><br>" +JSON.stringify(masterFeed))
                            console.debug("Read user value for key", key, "from DB:", value)
                        }
                    })
    }
    function addToNameList(id, userName) {
        db.setValue("public/nameList/"+userName, id)
    }
    function checkUsernameAvailability(name) {
        let searchKey = name.charAt(0)
        db.getValue("public/nameList/"+name, {
                    }, function(success, key, value) {
                        if(success) {nativeUtils.displayMessageBox(qsTr("Try Again!"), qsTr("Username already exists"))}
                        else {dataModel.nameAvailable()}
                    })
    }
    function followUser(userID, userName) {
        let updateFollowCount
        updateFollowCount = userData.follows.follows_count + 1
        //add to your follows list
        db.setValue("userData/"+uuid+"/follows/follows_count", updateFollowCount)
        db.setValue("userData/"+uuid+"/follows/follows_list/"+userID+"/", {"id": userID, "name": userName})
        //add to their folllowers list
        let followerCount
        db.getValue("userData/"+userID+"/followers/followers_count", followerCount = value+1)
        db.setValue("userData/"+userID+"/followers/followers_count", followerCount)
        db.setValue("userData/"+userID+"/followers/followers_list/"+userData.id+"/", {"id": userData.id, "name": userData.username})

        //add their feed to yours
        db.getValue("userFeeds/"+userID, {}, function(success, key, value){ if(success){db.setValue("userFeeds/"+uuid+"/", value)}})
    }
    function startChat (chatName, participantID) {
        let chatID = "c-uid"+uniqueID()
        let messageID = uniqueID()
        let content = {
            "chat_name": chatName,
            "members": [participantID, uuid],
            "thread": [{
                    messageID: { // message id
                        "content": userData.name + " has started a chat!",
                        "created": Date.now(),
                        "senderId": "Turtle",
                        "senderName": "Session"
                    }
                }]
        }
        db.setValue("chats/"+chatID, content)
        db.setValue("userData/"+uuid+"/chats/",chatID)
    }
    function getChats() {
        db.getValue("userData/"+uuid+"/chats/", {
                        if(success){
                            for (var x in value){
                                db.getValue("chats/"+value[x])
                            }
                        }
                    })
    }
    function sendMessage(chatID,messageContent) {
        let messageID = uniqueID()
        db.setValue("chats/"+chatID+"/"+messageID+"/", messageContent)
    }
    function fanPosts(posterID, post, postID){
        db.getValue(posterID+"/followers", {
                        if(succcess){
                            for(var i in value){
                                db.setValue("feeds/"+value[i].id, postID, post)
                            }
                        }
                    })
    }
}
