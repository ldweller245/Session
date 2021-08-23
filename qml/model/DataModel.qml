import QtQuick 2.0
import Felgo 3.0
import "../Plugins"
import "../ModalPages"

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
    signal postSuccess

    property var remoteFilePath
    property var uuid
    property var rrole; property var rgender; property var rfirstname; property var rsurname; property var rusername; property var remail; property var rpassword; property var rbaseLocation; property var rexperience; property var rtfp; property var rspecialities; property var rage; property var rheightCM; property var rethnicity; property var rhairColor; property var rhairLength; property var rskinColor; property var reyeColor; property var rshoeSize; property var rwaist; property var rhips; property var rinseam; property var rsuitSize; property var rtattoo; property var rpiercing; property var rprofileImagePath; property var rbio; property var rbust; property var rdressSize
    property var regDetails: []
    property var regUserDetails: []
    property var otherUserData: []
    property var otherUserPortfolio: []

    property var viewPostData

    property var userID: userData.id

    readonly property string realtimeUserData: "userData/" + userData.id + "/"
    readonly property string realtimeMasterFeed: "masterFeed/"
    readonly property string realtimeUserFeed: "userFeeds/" + userData.id
    readonly property string realtimeChats: "chats/"
    readonly property string realtimeOtherUserDetails: "userData/" + otherUserID

    function uniqueID() {
        return Math.floor(Math.random() * Math.floor(Math.random() * Date.now()))
    }
    FirebaseConfig {id: firebaseConfig; storageBucket: "session-10d53.appspot.com";  projectId: "session-10d53"; databaseUrl: "https://session-10d53-default-rtdb.europe-west1.firebasedatabase.app/"; apiKey: Qt.platform.os === "android" ? "AIzaSyClEiWZ5tOnHpB0kl19W4guYMZXBw5k6Hw": "AIzaSyCWy_CbVSdDFJGwtTvhiNJYtK3VA6Ehj4Q"; applicationId:  Qt.platform.os === "android" ? "1:627724626656:android:74443461c4df304ccc7e85": "1:627724626656:ios:1a1ec445bbaf1efbcc7e85"}

    FirebaseDatabase {
        id: db; config: firebaseConfig; onReadCompleted: {if(success) {console.debug("Read value " +  JSON.stringify(value) + " for key " + key)}else {console.debug("Error with message: "  + value)}}
        onWriteCompleted: {if(success) {console.debug("Successfully wrote to DB")}else {console.debug("Write failed with error: " + message)}}
        realtimeValueKeys: [realtimeUserData, realtimeMasterFeed, realtimeUserFeed, realtimeChats, realtimeOtherUserDetails];
        onRealtimeValueChanged: {
            if(key === realtimeUserData) {
                console.log("<br><br><br><br>REALTIME_USER_DATA_UPDATE<br><br><br><br>")
                userData = []; userData = value;
            }
            else if(key === realtimeMasterFeed) {
                masterFeed = []; masterFeed = value
            }
            else if(key === realtimeUserFeed) {
                console.log("<br><br><br><br>REALTIME_USER_FEED_UPDATE<br><br><br><br>")
                userFeed.push(value[i]); app.userFeedChanged();
            }
            else if(key === realtimeChats) {
            }
            else if(key === realtimeOtherUserDetails) {
                console.log("<br> Other User Key: " + realtimeOtherUserDetails)
                otherUserData = value
                dataModel.otherUserDataChanged()
                console.log("<br>Other User Data: <br>" + JSON.stringify(otherUserData) + "<br><br>")
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
                storage.uploadFile(rprofileImagePath, uuid + Date.now() + ".png", function(progress, finished, success, downloadUrl) {
                    if(!finished) {
                    } else if (finished && success) {remoteFilePath = downloadUrl; addToNameList(uuid, rusername) ; db.setUserValue("details", regUserDetails); db.setValue("userData/"+uuid+"/profile_Pic_URL", remoteFilePath); userData = regDetails; registerPage.visible = false; loginPage.visible = false}
                })
            }
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
                                            getFeed(userData.id)
                                        }
                                    })
                                    db.setValue("userData/"+value+"/lastActive", Date.now())
                                }
                            })
            console.debug("User login " + success + " - " + message);
            if(success) {registerPage.visible = false; loginPage.visible = false}
            getMasterFeed()
        }
    }
    FirebaseStorage {id: storage; config: firebaseConfig}

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
    //
    //
    // registration section
    function registerUser(role, gender, firstname, surname, username, email, password, baseLocation, experience, tfp, specialities, age, heightCM, ethnicity, hairColor, hairLength, skinColor, eyeColor, shoeSize, waist, hips, inseam, suitSize, tattoo, piercing,  profileImagePath, bio,bust, dressSize) {
        firebaseAuth.logoutUser()
        uuid = uniqueID()
        rrole = role; rgender = gender; rfirstname = firstname; rsurname = surname
        rusername = username; remail = email; rpassword = password; rbaseLocation = baseLocation
        rexperience = experience; rtfp = tfp; rspecialities = specialities; rage = age
        rheightCM = heightCM; rethnicity = ethnicity; rhairColor = hairColor; rhairLength = hairLength
        rskinColor = skinColor; reyeColor = eyeColor; rshoeSize = shoeSize; rwaist = waist
        rhips = hips; rinseam = inseam; rsuitSize = suitSize; rtattoo = tattoo
        rpiercing = piercing; rprofileImagePath = profileImagePath; rbio = bio; rbust = bust
        rdressSize = dressSize; remoteFilePath = profileImagePath

        if(role === "Model") {
            if(gender === "Male"){
                regDetails = ({"id": uuid,
                                  "role": rrole, "gender": rgender,"firstname": rfirstname, "surname": rsurname,
                                  "username": rusername, "email": remail, "location": rbaseLocation, "specialities": rspecialities,
                                  "profile_Pic_URL": remoteFilePath, "bio": rbio, "lastActive": new Date().getTime(),
                                  "blocked_by_user": false, "has_blocked_user": false, "followed_by_user": true, "follows_user": true,
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
                                      "Experience": rexperience, "TFP": rtfp, "Age": rage, "Height": rheightCM,
                                      "Ethnicity": rethnicity, "Hair Color": rhairColor, "Hair Length": rhairLength, "Skin": rskinColor,
                                      "Eyes": reyeColor, "Shoe": rshoeSize, "Waist": rwaist, "Inseam": rinseam,
                                      "Suit": rsuitSize, "Piercings": rpiercing, "Tattoos": rtattoo
                                  }
                              })
            }else if(gender === "Female") {
                regDetails = ({"id": uuid,
                                  "role": rrole, "gender": rgender, "firstname": rfirstname, "surname": rsurname,
                                  "username": rusername, "email": remail, "location": rbaseLocation, "specialities": rspecialities,
                                  "profile_Pic_URL": remoteFilePath, "bio": rbio, "lastActive": new Date().getTime(), "blocked_by_user": false,
                                  "has_blocked_user": false, "followed_by_user": true, "follows_user": true, "feedCount": 0,
                                  "followers": {
                                      "follower_count": 0,
                                      "follower_list": {}
                                  },
                                  "follows": {
                                      "follow_count": 0,
                                      "follow_list": {}
                                  },
                                  "measurements": {
                                      "Experience": rexperience, "TFP": rtfp, "Age": rage, "Height": rheightCM,
                                      "Ethnicity": rethnicity, "Hair Color": rhairColor, "Hair Length": rhairLength, "Skin": rskinColor,
                                      "Eyes": reyeColor, "Shoe": rshoeSize, "Waist": rwaist, "Hips": rhips,
                                      "Bust": rbust, "Dress": rdressSize, "Piercings": rpiercing, "Tattoos": rtattoo
                                  }
                              })
            }else {
                regDetails = ({"id": uuid,
                                  "role": rrole,
                                  "firstname": rfirstname, "surname": rsurname, "username": rusername, "gender": rgender,
                                  "email": remail, "location": rbaseLocation, "specialities": rspecialities,
                                  "profile_Pic_URL": remoteFilePath, "bio": rbio, "lastActive": new Date().getTime(),
                                  "blocked_by_user": false, "has_blocked_user": false, "followed_by_user": true, "follows_user": true, "feedCount": 0,
                                  "followers": {
                                      "follower_count": 0,
                                      "follower_list": {}
                                  },
                                  "follows": {
                                      "follow_count": 0,
                                      "follow_list": {}
                                  },
                                  "measurements": {
                                      "Experience": rexperience, "TFP": rtfp, "Age": rage, "Height": rheightCM,
                                      "Ethnicity": rethnicity, "Hair Color": rhairColor, "Hair Length": rhairLength, "Skin": rskinColor,
                                      "Eyes": reyeColor, "Shoe": rshoeSize, "Waist": rwaist, "Hips": rhips,
                                      "Inseam": rinseam, "Suit": rsuitSize, "Bust": rbust, "Dress": rdressSize,
                                      "Piercings": rpiercing, "Tattoos": rtattoo
                                  }
                              })

            }
        } else {
            regDetails = ({"id": uuid,
                              "role": rrole, "gender": rgender, "firstname": rfirstname, "surname": rsurname,
                              "username": rusername, "email": remail, "location": rbaseLocation, "specialities": rspecialities,
                              "profile_Pic_URL": remoteFilePath, "bio": rbio, "lastActive": new Date().getTime(), "blocked_by_user": false,
                              "has_blocked_user": false, "followed_by_user": true, "follows_user": true, "feedCount": 0,
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
        regUserDetails = {"id": uuid, "role": rrole, "firstname": rfirstname, "surname": rsurname, "username": rusername, "email": remail}
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
    //end registration functions
    //
    //
    //
    //
    //Feed Functions
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
    function getFeed(uuid) {
        db.getValue("userFeeds/"+uuid, {
                    }, function(success, key, value) {
                        if(success){
                            userFeed = []
                            for(var i in value) {
                                userFeed.push(value[i])
                            }
                            app.userFeedChanged()
                        }
                    }
                    )
    }
    function getMasterFeed() {
        /*db.getValue("masterFeed/", {
                        //orderByValue: true,  //order by value before limiting and filtering
                        //startAt: 5,          //return only values greater than or equal to 5
                        //endAt: 1000,         //return only values less than or equal to 1000
                        //limitToFirst: 2     //return only first 10 sub-keys/values
                    }, function(success, key, value) {
                        if(success) {
                            for(var i in value) {
                                masterFeed.push(value[i])
                            }
                            app.masterFeedChanged()
                            console.log("MASTER FEED: <br><br>" +JSON.stringify(masterFeed)+"<br><br><br><br><br>")
                        }
                    }
                    )*/
    }
    //end Feed Functions
    //
    //
    //
    //
    //post Functions
    function createPost(postImagePath, img_height, img_width, post_description, team, location, tag) {
        let updateFeedCount = userData.feedCount +1
        let postID = "p-uid"+uniqueID() + "-" + uniqueID()

        storage.uploadFile(postImagePath, userData.id + Date.now() + ".png", function(progress, finished, success, downloadUrl) {
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
                        "username": userData.username,
                        "profile_Pic_URL": userData.profile_Pic_URL,
                        "baseLocarion": userData.location

                    },
                    "post_description" : post_description,
                    "timestamp": Date.now(),
                    "team": team,
                    "liked_by":{
                        "count":0,
                        "liked_by_me": false
                    },
                    "tag": tag,
                    "location": location
                }
                db.setValue("masterFeed/"+postID, userPost)
                db.setValue("userFeeds/"+userData.id+"/"+postID, userPost)
                db.setValue("userData/"+userData.id+"/feed_posts/"+postID, userPost)
                fanPosts(userPost, postID)
                // add posted complete anim
                navigationRoot.currentIndex = 0;
                dataModel.postSuccess()
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
    function getPost(postID) {
        userFeed.forEach(function(item) {
            if(item.id === postID) {
                viewPostData = item
            }
        })
        return
    }
    function fanPosts(post, postID){
        let followers = userData.followers.followers_list
        for(var i in followers) {
            console.log(i)
            db.setValue("userFeeds/"+i+"/"+postID, post)
        }
    }
    //end Post Functions
    //
    //
    //
    //
    //Event(shoots) Functions
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
    //end Events Functions
    //
    //
    //
    //
    // User Functions
    function updateUserData() {
    }
    function searchUsers(searchString) {
        console.log("Search String: "+ searchString)
        db.getValue("public/nameList/", {
                        orderByKeys: true,
                        startAt: {key:  searchString},
                        endAt: {key: searchString + "~"},
                        limitToFirst: 10,
                    }, function(success, key, value) {
                        if(success) {
                            searchArr = []
                            for(var i in value){
                            searchArr.push({name: i, id: value[i]})
                            }
                            app.searchArrChanged()
                            console.log("<br><br>Read user value for key", key, "<br><br>from DB:", JSON.stringify(searchArr)+ "searchArrLength: "+searchArr.length)
                        }
                    })
    }
    function getUser(userID) {
        db.getValue("userData/" +userID, {
                    }, function(success, key, value) {
                        if(success) {
                            otherUserData = []
                            otherUserData = value
                            dataModel.otherUserDataChanged()
                            let feedPosts = value.feed_posts
                            otherUserPortfolio = []
                            for(var i in feedPosts){
                                otherUserPortfolio.push(feedPosts[i])
                            }
                            dataModel.otherUserPortfolioChanged()
                        }
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
        db.getValue("userData/"+userID+"/feed_posts", {}, function(success, key, value){ if(success){db.setValue("userFeeds/"+uuid+"/", value)}})
    }
    //
    //
    // IM functions
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
    // end IM functions
    //
    //
    //
    //
    //Calendar Functions
    function addCalendarItem(){

    }
    function removeCalendarItem(){

    }
    function editCalendarItem(){

    }
    // end Calendar functions
    //
    //
    //
    //
    // Casting Functions
    function createCasting(){

    }
    function editCasting(){

    }
    function deleteCasting(){

    }
    //End Casting Functions
    //
    //
}
