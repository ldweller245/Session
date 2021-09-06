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
    property var currentChat: []

    property var viewPostData

    property var userID: userData.id

    readonly property string realtimeUserData: "userData/" + userData.id + "/"
    readonly property string realtimeMasterFeed: "masterFeed/"
    readonly property string realtimeUserFeed: "userFeeds/" + userData.id
    readonly property string realtimeChats: "chats/"
    readonly property string realtimeOtherUserDetails: "userData/" + otherUserID

    function SHA256(s){
    var chrsz   = 8;
    var hexcase = 0;
    function safe_add (x, y) {
        var lsw = (x & 0xFFFF) + (y & 0xFFFF);
        var msw = (x >> 16) + (y >> 16) + (lsw >> 16);
        return (msw << 16) | (lsw & 0xFFFF);
    }
    function S (X, n) { return ( X >>> n ) | (X << (32 - n)); }
    function R (X, n) { return ( X >>> n ); }
    function Ch(x, y, z) { return ((x & y) ^ ((~x) & z)); }
    function Maj(x, y, z) { return ((x & y) ^ (x & z) ^ (y & z)); }
    function Sigma0256(x) { return (S(x, 2) ^ S(x, 13) ^ S(x, 22)); }
    function Sigma1256(x) { return (S(x, 6) ^ S(x, 11) ^ S(x, 25)); }
    function Gamma0256(x) { return (S(x, 7) ^ S(x, 18) ^ R(x, 3)); }
    function Gamma1256(x) { return (S(x, 17) ^ S(x, 19) ^ R(x, 10)); }
    function core_sha256 (m, l) {
        var K = new Array(0x428A2F98, 0x71374491, 0xB5C0FBCF, 0xE9B5DBA5, 0x3956C25B, 0x59F111F1, 0x923F82A4, 0xAB1C5ED5, 0xD807AA98, 0x12835B01, 0x243185BE, 0x550C7DC3, 0x72BE5D74, 0x80DEB1FE, 0x9BDC06A7, 0xC19BF174, 0xE49B69C1, 0xEFBE4786, 0xFC19DC6, 0x240CA1CC, 0x2DE92C6F, 0x4A7484AA, 0x5CB0A9DC, 0x76F988DA, 0x983E5152, 0xA831C66D, 0xB00327C8, 0xBF597FC7, 0xC6E00BF3, 0xD5A79147, 0x6CA6351, 0x14292967, 0x27B70A85, 0x2E1B2138, 0x4D2C6DFC, 0x53380D13, 0x650A7354, 0x766A0ABB, 0x81C2C92E, 0x92722C85, 0xA2BFE8A1, 0xA81A664B, 0xC24B8B70, 0xC76C51A3, 0xD192E819, 0xD6990624, 0xF40E3585, 0x106AA070, 0x19A4C116, 0x1E376C08, 0x2748774C, 0x34B0BCB5, 0x391C0CB3, 0x4ED8AA4A, 0x5B9CCA4F, 0x682E6FF3, 0x748F82EE, 0x78A5636F, 0x84C87814, 0x8CC70208, 0x90BEFFFA, 0xA4506CEB, 0xBEF9A3F7, 0xC67178F2);
        var HASH = new Array(0x6A09E667, 0xBB67AE85, 0x3C6EF372, 0xA54FF53A, 0x510E527F, 0x9B05688C, 0x1F83D9AB, 0x5BE0CD19);
        var W = new Array(64);
        var a, b, c, d, e, f, g, h, i, j;
        var T1, T2;
        m[l >> 5] |= 0x80 << (24 - l % 32);
        m[((l + 64 >> 9) << 4) + 15] = l;
        for ( var i = 0; i<m.length; i+=16 ) {
            a = HASH[0];
            b = HASH[1];
            c = HASH[2];
            d = HASH[3];
            e = HASH[4];
            f = HASH[5];
            g = HASH[6];
            h = HASH[7];
            for ( var j = 0; j<64; j++) {
                if (j < 16) W[j] = m[j + i];
                else W[j] = safe_add(safe_add(safe_add(Gamma1256(W[j - 2]), W[j - 7]), Gamma0256(W[j - 15])), W[j - 16]);
                T1 = safe_add(safe_add(safe_add(safe_add(h, Sigma1256(e)), Ch(e, f, g)), K[j]), W[j]);
                T2 = safe_add(Sigma0256(a), Maj(a, b, c));
                h = g;
                g = f;
                f = e;
                e = safe_add(d, T1);
                d = c;
                c = b;
                b = a;
                a = safe_add(T1, T2);
            }
            HASH[0] = safe_add(a, HASH[0]);
            HASH[1] = safe_add(b, HASH[1]);
            HASH[2] = safe_add(c, HASH[2]);
            HASH[3] = safe_add(d, HASH[3]);
            HASH[4] = safe_add(e, HASH[4]);
            HASH[5] = safe_add(f, HASH[5]);
            HASH[6] = safe_add(g, HASH[6]);
            HASH[7] = safe_add(h, HASH[7]);
        }
        return HASH;
    }
    function str2binb (str) {
        var bin = Array();
        var mask = (1 << chrsz) - 1;
        for(var i = 0; i < str.length * chrsz; i += chrsz) {
            bin[i>>5] |= (str.charCodeAt(i / chrsz) & mask) << (24 - i%32);
        }
        return bin;
    }
    function Utf8Encode(string) {
        string = string.replace(/\r\n/g,"\n");
        var utftext = "";
        for (var n = 0; n < string.length; n++) {
            var c = string.charCodeAt(n);
            if (c < 128) {
                utftext += String.fromCharCode(c);
            }
            else if((c > 127) && (c < 2048)) {
                utftext += String.fromCharCode((c >> 6) | 192);
                utftext += String.fromCharCode((c & 63) | 128);
            }
            else {
                utftext += String.fromCharCode((c >> 12) | 224);
                utftext += String.fromCharCode(((c >> 6) & 63) | 128);
                utftext += String.fromCharCode((c & 63) | 128);
            }
        }
        return utftext;
    }
    function binb2hex (binarray) {
        var hex_tab = hexcase ? "0123456789ABCDEF" : "0123456789abcdef";
        var str = "";
        for(var i = 0; i < binarray.length * 4; i++) {
            str += hex_tab.charAt((binarray[i>>2] >> ((3 - i%4)*8+4)) & 0xF) +
            hex_tab.charAt((binarray[i>>2] >> ((3 - i%4)*8  )) & 0xF);
        }
        return str;
    }
    s = Utf8Encode(s);
    return binb2hex(core_sha256(str2binb(s), s.length * chrsz));
}



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
                otherUserData = value
                dataModel.otherUserDataChanged()
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
    function editEvent() {

    }
    function deleteEvent() {

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
                        "orderByKey": true,
                        "startAt": searchString,
                        "endAt": searchString+"~",
                        "limitToFirst": 10,
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
        updateFollowCount = userData.follows.follow_count + 1
        //add to your follows list
        db.setValue("userData/"+userData.id+"/follows/follow_count", updateFollowCount)
        db.setValue("userData/"+userData.id+"/follows/follow_list/"+userID+"/", {"id": userID, "name": userName})
        //add to their folllowers list
        let followerCount
        db.getValue("userData/"+userID+"/followers/follower_count", {}, function(success, key, value){followerCount = value; followerCount = followerCount +1;db.setValue("userData/"+userID+"/followers/follower_count", followerCount)})
        db.setValue("userData/"+userID+"/followers/followers_list/"+userData.id+"/", {"id": userData.id, "name": userData.username})
        //add their feed to yours
        let otherUserFeed
        db.getValue("userData/"+userID+"/feed_posts", {}, function(success, key, value){ if(success){otherUserFeed = value; db.setValue("userFeeds/"+userData.id+"/", otherUserFeed)}})
    }
    function unfollowUser(userID) {
        let updateFollowCount
        updateFollowCount = userData.follows.follow_count -1

        db.setValue("userData/"+userData.id+"/follows/follow_count", updateFollowCount)
        db.setValue("userData/"+userData.id+"/follows/follow_list/"+userID+"/", null)

        let followerCount
        db.getValue("userData/"+userID+"/followers/follower_count", {}, function(success, key, value){followerCount = value; followerCount = followerCount -1;db.setValue("userData/"+userID+"/followers/follower_count", followerCount)})
        db.setValue("userData/"+userID+"/followers/followers_list/"+userData.id+"/", null)
        //remove their feed from yours
        //let otherUserFeed
        //db.getValue("userData/"+userID+"/feed_posts", {}, function(success, key, value){ if(success){otherUserFeed = value; db.setValue("userFeeds/"+userData.id+"/", otherUserFeed)}})
    }
    function editUserData() {

    }
    //
    //
    // IM functions
    function startGroupChat (chatName, participantID) {
        let chatID = "c-uid"+uniqueID() + "-" + uniqueID()
        let messageID = uniqueID()
        let content = {
            "chatID": chatID,
            "chat_name": chatName,
            "members": [participantID, userData.id],
            "thread": [{
                    "0001": { // message id
                        "content": userData.username + " has started a chat!",
                        "created": Date.now(),
                        "senderId": "Turtle",
                        "senderName": "Session"
                    }
                }]
        }
        //message layout on convo page
        /*property var blindTextMsgs: [
          { text: "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration.", me: false },
          { text: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.", me: true },
          { text: "All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words.", me: false },
          { text: "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration.", me: false },
          { text: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.", me: true },
          { text: "All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words.", me: false }
        ]*/
        db.setValue("chats/"+chatID, content)
        //chats/123456
        db.setValue("userData/"+userData.id+"/chats/"+chatID, chatID)
        for (var i in participantID){
            db.setValue("userData/"+i+"/chats/"+chatID, chatID)
        }
        //userData/eddID/chats/Key: 123456 value: 123456
    }
    
    
    function refreshChat(chatiD) {
        db.getValue("chats/"+chatiD, {
                        if(success){
                            //updateModel

                        }
                    })
    }
    
    
    
    function sendMessage(chatID,messageContent, member) {
        var chatExists = userData.chats
        var recipients = userData.chats[chatID].members
        let messageID = uniqueID()

        if(chatExists.indexOf(chatID) === -1){
            //not found
            db.setValue("chats/"+chatID+"/chatID",chatID)
            for(var x in member){
                db.setValue("userData/"+x+"/chats/"+chatID, chatID)
                db.setValue("chats/"+chatID+"/members/",x)
                //send notification -"Edward has started a chat"
            }
        }
        else {
            //found
            for(var i in recipients) {
                //send notification "New message from Edward
            }
        }
        db.setValue("chats/"+chatID+"/thread/"+messageID, messageContent)
    }
    
    
    
    function deleteMessage(chatID, messageID) {
        db.setValue("chats/"+chatID+"/thread/"+messageID, null)
    }
    
    
    function editMessage(chatID, messageID, content){
        db.setValue("chats/"+chatID+"/thread/"+messageID+"/content", content)
    }
    
    
    function leaveChat(chatID) {
        db.setValue("chats/"+chatID+"/members/"+userData.id+"/", null)
        db.setValue("userData/"+userData.id+"/chats/"+chatID, null)
    }
    
    
    function getChat (userID) {    
        //userData/edd/chats/123456/0 --- edd123    
        //                          1 --- kati456
        
        let chats = userData.chats
        
        chats.forEach(function(item) {        
            if(item.length ===2 && item[0] === userData.id && item[1]===userID || item.length ===2 && item[1] === userData.id && item[0]===userID) {
                db.getValue("chats/"+item, {
                    "orderByKey": true,
                    "limitToLast": 50,
                    }, function(success, key, value) {
                        if(success) {
                        chatData = value
                        }
                    })
            }
        })
        return              
        /*for(var i in chats){
            if(chats[i].includes(userData.id && userID)){
                if(chats[i].length === 2){
                    //send signal to push page with details
                    //correct chat. change to array.every ?                                                                                                   
                } else {
                    //emptty chat
                    //keep looking
                }
            }
            else {
                //empty chat
            }
        }*/
    }

    // end IM functions
    //
    //
    //
    //
    //Calendar Functions
    function getCalendarData() {
    calendarListModel.push(
    {
    date: new Date(calendarViewModel[idx].date).getTime(), 
    name: calendarViewModel[idx].name, 
    details: calendarViewModel[idx].details, 
    status: calendarViewModel[idx].status});
        
    }
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
