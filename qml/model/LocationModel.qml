import QtQuick 2.0
import Felgo 3.0

Item {

    id: locationModel

    property var townData: [
        {
            "name": "Abingdon-onThames",
            "county": "Oxfordshire"
        },
        {
            "name": "Accrington",
            "county": "Lancashire"
        },
        {
            "name": "Acle",
            "county": "Norfolk"
        },
        {
            "name": "Acton",
            "county": "Greater London"
        },
        {
            "name": "Adlington",
            "county": "Lancashire"
        },
        {
            "name": "Alcester",
            "county": "Warwickshire"
        },
        {
            "name": "Aldeburgh",
            "county": "Suffolk"
        },
        {
            "name": "Aldershot",
            "county": "Hampshire"
        },
        {
            "name": "Alford",
            "county": "Lincolnshire"
        },
        {
            "name": "Alfreton",
            "county": "Derbyshire"
        },
        {
            "name": "Alnwick",
            "county": "Northumberland",
        },
        {
            "name": "Alsager",
            "county": "Cheshire"
        },
        {
            "name": "Alston",
            "county": "Cumbria"
        },
        {
            "name": "Alton",
            "county": "Hampshire"
        },
        {
            "name": "Altrincham",
            "county": "Greater Manchester"
        },
        {
            "name": "Amble",
            "county": "Northumberland"
        },

        {
            "name": "Ambleside",
            "county": "Cumbria"
        },

        {
            "name": "Amersham",
            "county": "Buckinghamshire"
        },

        {
            "name": "Amesbury",
            "county": "Wiltshire"
        },

        {
            "name": "Ampthill",
            "county": "Bedfordshire"
        },

        {
            "name": "Andover",
            "county": "Hampshire"
        },

        {
            "name": "Appleby-in-Westmorland",
            "county": "Cumbria"
        },

        {
            "name": "Arlesey",
            "county": "Bedfordshire"
        },

        {
            "name": "Arundel",
            "county": "West Sussex"
        },

        {
            "name": "Ashbourne",
            "county": "Derbyshire"
        },

        {
            "name": "Ashburton",
            "county": "Devon"
        },

        {
            "name": "Ashby-de-la-Zouch",
            "county": "Leicestershire"
        },

        {
            "name": "Ashford",
            "county": "Kent"
        },

        {
            "name": "Ashington",
            "county": "Northumberland"
        },

        {
            "name": "Ashton-under-Lyne",
            "county": "Greater Manchester"
        },

        {
            "name": "Askern",
            "county": "South Yorkshire"
        },

        {
            "name": "Aspatria",
            "county": "Cumbria"
        },

        {
            "name": "Atherstone",
            "county": "Warwickshire"
        },

        {
            "name": "Attleborough",
            "county": "Norfolk"
        },

        {
            "name": "Axbridge",
            "county": "Somerset"
        },

        {
            "name": "Axminster",
            "county": "Devon"
        },

        {
            "name": "Aylesbury",
            "county": "Buckinghamshire"
        },

        {
            "name": "Aylsham",
            "county": "Norfolk"
        },

        ////
        ////
        //B
        ////
        ////

        {
            "name": "Bacup",
            "county": "Lancashire"
        },

        {
            "name": "Bakewell",
            "county": "Derbyshire"
        },

        {
            "name": "Bampton",
            "county": "Devon"
        },

        {
            "name": "Banbury",
            "county": "Oxfordshire"
        },

        {
            "name": "Barking",
            "county": "Greater London"
        },

        {
            "name": "Barnard Castle",
            "county": "Durham"
        },

        {
            "name": "Barnes",
            "county": "Greater London"
        },

        {
            "name": "Barnet",
            "county": "Greater London"
        },

        {
            "name": "Barnoldswick",
            "county": "Lancashire"
        },

        {
            "name": "Barnsley",
            "county": "South Yorkshire"
        },

        {
            "name": "Barnstaple",
            "county": "Devon"
        },

        {
            "name": "Barrow-in-Furness",
            "county": "Cumbria"
        },

        {
            "name": "Barton-upon-Humber",
            "county": "Lincolnshire"
        },

        {
            "name": "Basingstoke",
            "county": "Hampshire"
        },

        {
            "name": "Batley",
            "county": "West Yorkshire"
        },

        {
            "name": "Battle",
            "county": "East Sussex"
        },

        {
            "name": "Bawtry",
            "county": "South Yorkshire"
        },

        {
            "name": "Beaconsfield",
            "county": "Buckinghamshire"
        },

        {
            "name": "Beaminster",
            "county": "Dorset"
        },

        {
            "name": "Bebington",
            "county": "Merseyside"
        },

        {
            "name": "Beccles",
            "county": "Suffolk"
        },

        {
            "name": "Beckenham",
            "county": "Greater London"
        },

        {
            "name": "Bedale",
            "county": "North Yorkshire"
        },

        {
            "name": "Bedford",
            "county": "Bedfordshire"
        },


        {
            "name": "Bedworth",
            "county": "Warwickshire"
        },


        {
            "name": "Belper",
            "county": "Derbyshire"
        },


        {
            "name": "Bentham",
            "county": "North Yorkshire"
        },


        {
            "name": "Berkeley",
            "county": "Gloucestershire"
        },


        {
            "name": "Berkhamsted",
            "county": "Hertfordshire"
        },


        {
            "name": "Berwick-upon-Tweed",
            "county": "Northumberland"
        },


        {
            "name": "Beverley",
            "county": "East Riding of Yorkshire"
        },


        {
            "name": "Bewdley",
            "county": "Worcestershire"
        },


        {
            "name": "Bexhill-on-Sea",
            "county": "East Sussex"
        },


        {
            "name": "Bexley",
            "county": "Greater London"
        },


        {
            "name": "Bicester",
            "county": "Oxfordshire"
        },


        {
            "name": "Biddulph",
            "county": "Staffordshire"
        },


        {
            "name": "Bideford",
            "county": "Devon"
        },


        {
            "name": "Biggleswade",
            "county": "Bedfordshire"
        },


        {
            "name": "Billericay",
            "county": "Essex"
        },


        {
            "name": "Billingham",
            "county": "Durham"
        },


        {
            "name": "Bilston",
            "county": "West Midlands"
        },


        {
            "name": "Bingham",
            "county": "Nottinghamshire"
        },


        {
            "name": "Bingley",
            "county": "West Yorkshire"
        },


        {
            "name": "Birchwood",
            "county": "Cheshire"
        },


        {
            "name": "Birkenhead",
            "county": "Merseyside"
        },


        {
            "name": "Bishop Auckland",
            "county": "Durham"
        },


        {
            "name": "Bishop's Castle",
            "county": "Shropshire"
        },


        {
            "name": "Bishop's Stortford",
            "county": "Hertfordshire"
        },


        {
            "name": "Bishop's Waltham",
            "county": "Hampshire"
        },


        {
            "name": "Blackburn",
            "county": "Lancashire"
        },


        {
            "name": "Blackpool",
            "county": "Lancashire"
        },


        {
            "name": "Blackrod",
            "county": "Greater Manchester"
        },


        {
            "name": "Blackwater and Hawley",
            "county": "Hampshire"
        },


        {
            "name": "Blandford Forum",
            "county": "Dorset"
        },


        {
            "name": "Bletchley and Fenny Stratford",
            "county": "Buckinghamshire"
        },


        {
            "name": "Blyth",
            "county": "Northumberland"
        },


        {
            "name": "Bodmin",
            "county": "Cornwall"
        },


        {
            "name": "Bognor Regis",
            "county": "West Sussex"
        },


        {
            "name": "Bollington",
            "county": "Cheshire"
        },


        {
            "name": "Bolsover",
            "county": "Derbyshire"
        },


        {
            "name": "Bolton",
            "county": "Greater Manchester"
        },


        {
            "name": "Bootle",
            "county": "Merseyside"
        },


        {
            "name": "Bordon",
            "county": "Hampshire"
        },


        {
            "name": "Boroughbridge",
            "county": "North Yorkshire"
        },


        {
            "name": "Boston",
            "county": "Lincolnshire"
        },


        {
            "name": "Bottesford",
            "county": "Lincolnshire"
        },


        {
            "name": "Bourne",
            "county": "Lincolnshire"
        },


        {
            "name": "Bournemouth",
            "county": "Dorset"
        },


        {
            "name": "Bovey Tracey",
            "county": "Devon"
        },


        {
            "name": "Brackley",
            "county": "Northamptonshire"
        },


        {
            "name": "Bradford-on-Avon",
            "county": "Wiltshire"
        },


        {
            "name": "Brading",
            "county": "Isle of Wight"
        },


        {
            "name": "Bradley Stoke",
            "county": "Gloucestershire"
        },


        {
            "name": "Bradninch",
            "county": "Devon"
        },


        {
            "name": "Braintree",
            "county": "Essex"
        },


        {
            "name": "Brampton",
            "county": "Cumbria"
        },


        {
            "name": "Brandon",
            "county": "Suffolk"
        },


        {
            "name": "Braunstone Town",
            "county": "Leicestershire"
        },


        {
            "name": "Brentford",
            "county": "Greater London"
        },


        {
            "name": "Brentwood",
            "county": "Essex"
        },


        {
            "name": "Bridgnorth",
            "county": "Shropshire"
        },


        {
            "name": "Bridgwater",
            "county": "Somerset"
        },


        {
            "name": "Bridlington",
            "county": "East Riding of Yorkshire"
        },


        {
            "name": "Bridport",
            "county": "Dorset"
        },


        {
            "name": "Brierfield",
            "county": "Lancashire"
        },


        {
            "name": "Brierley",
            "county": "South Yorkshire"
        },


        {
            "name": "Brigg",
            "county": "Lincolnshire"
        },


        {
            "name": "Brighouse",
            "county": "West Yorkshire"
        },


        {
            "name": "Brightlingsea",
            "county": "Essex"
        },


        {
            "name": "Brixham",
            "county": "Devon"
        },


        {
            "name": "Broadstairs and St Peter's",
            "county": "Kent"
        },


        {
            "name": "Bromborough",
            "county": "Merseyside"
        },


        {
            "name": "Bromley",
            "county": "Greater London"
        },


        {
            "name": "Bromsgrove",
            "county": "Worcestershire"
        },


        {
            "name": "Bromyard",
            "county": "Herefordshire"
        },


        {
            "name": "Broseley",
            "county": "Shropshire"
        },


        {
            "name": "Brough",
            "county": "East Riding of Yorkshire"
        },


        {
            "name": "Broughton",
            "county": "Lincolnshire"
        },


        {
            "name": "Broughton-in-Furness",
            "county": "Cumbria"
        },


        {
            "name": "Bruton",
            "county": "Somerset"
        },


        {
            "name": "Buckfastleigh",
            "county": "Devon"
        },


        {
            "name": "Buckingham",
            "county": "Buckinghamshire"
        },


        {
            "name": "Bude-Stratton",
            "county": "Cornwall"
        },


        {
            "name": "Budleigh Salterton",
            "county": "Devon"
        },


        {
            "name": "Bulwell",
            "county": "Nottinghamshire"
        },


        {
            "name": "Bungay",
            "county": "Suffolk"
        },


        {
            "name": "Buntingford",
            "county": "Hertfordshire"
        },


        {
            "name": "Burford",
            "county": "Oxfordshire"
        },


        {
            "name": "Burgess Hill",
            "county": "West Sussex"
        },


        {
            "name": "Burgh-le-Marsh",
            "county": "Lincolnshire"
        },


        {
            "name": "Burnham-on-Crouch",
            "county": "Essex"
        },


        {
            "name": "Burnham-on-Sea",
            "county": "Somerset"
        },


        {
            "name": "Burnley",
            "county": "Lancashire"
        },

        {
            "name": "Burntwood",
            "county": "Staffordshire"
        },


        {
            "name": "Burslem",
            "county": "Staffordshire"
        },


        {
            "name": "Burton Latimer",
            "county": "Northamptonshire"
        },


        {
            "name": "Burton upon Trent",
            "county": "Staffordshire"
        },


        {
            "name": "Bury",
            "county": "Greater Manchester"
        },


        {
            "name": "Bury St Edmunds",
            "county": "Suffolk"
        },


        {
            "name": "Bushey",
            "county": "Hertfordshire"
        },


        {
            "name": "Buxton",
            "county": "Derbyshire"
        },


        ///
        ///
        //C
        ///
        ///

        {
            "name": "Caistor",
            "county": "Lincolnshire"
        },


        {
            "name": "Callington",
            "county": "Cornwall"
        },


        {
            "name": "Calne",
            "county": "Wiltshire"
        },


        {
            "name": "Camborne",
            "county": "Cornwall"
        },


        {
            "name": "Camelford",
            "county": "Cornwall"
        },


        {
            "name": "Cannock",
            "county": "Staffordshire"
        },


        {
            "name": "Canvey Island",
            "county": "Essex"
        },


        {
            "name": "Carnforth",
            "county": "Lancashire"
        },


        {
            "name": "Carlton Colville",
            "county": "Suffolk"
        },


        {
            "name": "Carshalton",
            "county": "Greater London"
        },


        {
            "name": "Carterton",
            "county": "Oxfordshire"
        },


        {
            "name": "Castle Cary",
            "county": "Somerset"
        },


        {
            "name": "Castleford",
            "county": "West Yorkshire"
        },


        {
            "name": "Chagford",
            "county": "Devon"
        },


        {
            "name": "Chapel-en-le-Frith",
            "county": "Derbyshire"
        },


        {
            "name": "Chard",
            "county": "Somerset"
        },


        {
            "name": "Charlbury",
            "county": "Oxfordshire"
        },

        {
            "name": "Chatham",
            "county": "Kent"
        },

        {
            "name": "Chatteris",
            "county": "Cambridgeshire"
        },

        {
            "name": "Cheadle",
            "county": "Staffordshire"
        },

        {
            "name": "Cheltenham",
            "county": "Gloucestershire"
        },

        {
            "name": "Chertsey",
            "county": "Surrey"
        },

        {
            "name": "Chesham",
            "county": "Buckinghamshire"
        },

        {
            "name": "Cheshunt",
            "county": "Hertfordshire"
        },

        {
            "name": "Chesterfield",
            "county": "Derbyshire"
        },

        {
            "name": "Chester-le-Street",
            "county": "Durham"
        },

        {
            "name": "Chickerell",
            "county": "Dorset"
        },

        {
            "name": "Chilton",
            "county": "County Durham"
        },

        {
            "name": "Chingford",
            "county": "Greater London"
        },

        {
            "name": "Chippenham",
            "county": "Wiltshire"
        },

        {
            "name": "Chipping Campden",
            "county": "Gloucestershire"
        },

        {
            "name": "Chipping Norton",
            "county": "Oxfordshire"
        },

        {
            "name": "Chipping Sodbury",
            "county": "Gloucestershire"
        },

        {
            "name": "Chorley",
            "county": "Lancashire"
        },

        {
            "name": "Chorleywood",
            "county": "Hertfordshire"
        },

        {
            "name": "Christchurch",
            "county": "Dorset"
        },

        {
            "name": "Chudleigh",
            "county": "Devon"
        },

        {
            "name": "Chulmleigh",
            "county": "Devon"
        },

        {
            "name": "Church Stretton",
            "county": "Shropshire"
        },

        {
            "name": "Cinderford",
            "county": "Gloucestershire"
        },

        {
            "name": "Cirencester",
            "county": "Gloucestershire"
        },

        {
            "name": "Clare",
            "county": "Suffolk"
        },

        {
            "name": "Clay Cross",
            "county": "Derbyshire"
        },

        {
            "name": "Cleator Moor",
            "county": "Cumbria"
        },

        {
            "name": "Cleckheaton",
            "county": "West Yorkshire"
        },

        {
            "name": "Cleethorpes",
            "county": "Lincolnshire"
        },

        {
            "name": "Cleobury Mortimer",
            "county": "Shropshire"
        },

        {
            "name": "Clevedon",
            "county": "Somerset"
        },

        {
            "name": "Clitheroe",
            "county": "Lancashire"
        },

        {
            "name": "Clun",
            "county": "Shropshire"
        },

        {
            "name": "Coalville",
            "county": "Leicestershire"
        },

        {
            "name": "Cockermouth",
            "county": "Cumbria"
        },

        {
            "name": "Coggeshall",
            "county": "Essex"
        },

        {
            "name": "Colburn",
            "county": "North Yorkshire"
        },

        {
            "name": "Colchester",
            "county": "Essex"
        },

        {
            "name": "Coleford",
            "county": "Gloucestershire"
        },

        {
            "name": "Coleshill",
            "county": "Warwickshire"
        },

        {
            "name": "Colne",
            "county": "Lancashire"
        },

        {
            "name": "Colyton",
            "county": "Devon"
        },

        {
            "name": "Congleton",
            "county": "Cheshire"
        },

        {
            "name": "Conisbrough",
            "county": "South Yorkshire"
        },

        {
            "name": "Corbridge",
            "county": "Northumberland"
        },

        {
            "name": "Corby",
            "county": "Northamptonshire"
        },

        {
            "name": "Corringham",
            "county": "Essex"
        },

        {
            "name": "Corsham",
            "county": "Wiltshire"
        },

        {
            "name": "Cotgrave",
            "county": "Nottinghamshire"
        },

        {
            "name": "Cowes",
            "county": "Isle of Wight"
        },

        {
            "name": "Coulsdon",
            "county": "Greater London"
        },

        {
            "name": "Cramlington",
            "county": "Northumberland"
        },

        {
            "name": "Cranbrook",
            "county": "Kent"
        },

        {
            "name": "Craven Arms",
            "county": "Shropshire"
        },

        {
            "name": "Crawley",
            "county": "West Sussex"
        },

        {
            "name": "Crediton",
            "county": "Devon"
        },

        {
            "name": "Crewe",
            "county": "Cheshire"
        },

        {
            "name": "Crewkerne",
            "county": "Somerset"
        },

        {
            "name": "Cricklade",
            "county": "Wiltshire"
        },

        {
            "name": "Cromer",
            "county": "Norfolk"
        },

        {
            "name": "Crook",
            "county": "County Durham"
        },

        {
            "name": "Crosby",
            "county": "Merseyside"
        },

        {
            "name": "Crowborough",
            "county": "East Sussex"
        },

        {
            "name": "Croydon",
            "county": "Greater London"
        },

        {
            "name": "Crowland",
            "county": "Lincolnshire"
        },

        {
            "name": "Crowle",
            "county": "Lincolnshire"
        },

        {
            "name": "Cullompton",
            "county": "Devon"
        },

        ////
        ////
        //D
        ////
        ////

        {
            "name": "Dagenham",
            "county": "Greater London"
        },

        {
            "name": "Dalton-in-Furness",
            "county": "Cumbria"
        },

        {
            "name": "Darley Dale",
            "county": "Derbyshire"
        },

        {
            "name": "Darlington",
            "county": "Durham"
        },

        {
            "name": "Dartford",
            "county": "Kent"
        },

        {
            "name": "Dartmouth",
            "county": "Devon"
        },

        {
            "name": "Darwen",
            "county": "Lancashire"
        },

        {
            "name": "Daventry",
            "county": "Northamptonshire"
        },

        {
            "name": "Dawley",
            "county": "Shropshire"
        },

        {
            "name": "Dawlish",
            "county": "Devon"
        },

        {
            "name": "Deal",
            "county": "Kent"
        },

        {
            "name": "Denholme",
            "county": "West Yorkshire"
        },

        {
            "name": "Dereham",
            "county": "Norfolk"
        },

        {
            "name": "Desborough",
            "county": "Northamptonshire"
        },

        {
            "name": "Devizes",
            "county": "Wiltshire"
        },

        {
            "name": "Dewsbury",
            "county": "West Yorkshire"
        },

        {
            "name": "Didcot",
            "county": "Oxfordshire"
        },

        {
            "name": "Dinnington St John's",
            "county": "South Yorkshire"
        },

        {
            "name": "Diss",
            "county": "Norfolk"
        },

        {
            "name": "Doncaster",
            "county": "South Yorkshire"
        },

        {
            "name": "Dorchester",
            "county": "Dorset"
        },

        {
            "name": "Dorking",
            "county": "Surrey"
        },

        {
            "name": "Dover",
            "county": "Kent"
        },

        {
            "name": "Dovercourt",
            "county": "Essex"
        },

        {
            "name": "Downham Market",
            "county": "Norfolk"
        },

        {
            "name": "Driffield",
            "county": "East Riding of Yorkshire"
        },

        {
            "name": "Droitwich Spa",
            "county": "Worcestershire"
        },

        {
            "name": "Dronfield",
            "county": "Derbyshire"
        },

        {
            "name": "Dudley",
            "county": "West Midlands"
        },

        {
            "name": "Dukinfield",
            "county": "Greater Manchester"
        },

        {
            "name": "Dulverton",
            "county": "Somerset"
        },

        {
            "name": "Dunstable",
            "county": "Bedfordshire"
        },

        {
            "name": "Dunwich",
            "county": "Suffolk"
        },

        {
            "name": "Dursley",
            "county": "Gloucestershire"
        },

        ////
        ////
        //E
        ////
        ////

        {
            "name": "Ealing",
            "county": "Greater London"
        },

        {
            "name": "Earby",
            "county": "Lancashire"
        },

        {
            "name": "Earl Shilton",
            "county": "Leicestershire"
        },

        {
            "name": "Earley",
            "county": "Berkshire"
        },

        {
            "name": "Easingwold",
            "county": "North Yorkshire"
        },

        {
            "name": "East Cowes",
            "county": "Isle of Wight"
        },

        {
            "name": "East Grinstead",
            "county": "West Sussex"
        },

        {
            "name": "East Ham",
            "county": "Greater London"
        },

        {
            "name": "Eastbourne",
            "county": "East Sussex"
        },

        {
            "name": "Eastleigh",
            "county": "Hampshire"
        },

        {
            "name": "East Retford",
            "county": "Nottinghamshire"
        },

        {
            "name": "Eastwood",
            "county": "Nottinghamshire"
        },

        {
            "name": "Eccles",
            "county": "Greater Manchester"
        },

        {
            "name": "Eccleshall",
            "county": "Staffordshire"
        },

        {
            "name": "Edenbridge",
            "county": "Kent"
        },

        {
            "name": "Edgware",
            "county": "Greater London"
        },

        {
            "name": "Edmonton",
            "county": "Greater London"
        },

        {
            "name": "Egremont",
            "county": "Cumbria"
        },

        {
            "name": "Elland",
            "county": "West Yorkshire"
        },

        {
            "name": "Ellesmere",
            "county": "Shropshire"
        },

        {
            "name": "Ellesmere Port",
            "county": "Cheshire"
        },

        {
            "name": "Elstree and Borehamwood",
            "county": "Hertfordshire"
        },

        {
            "name": "Emsworth",
            "county": "Hampshire"
        },

        {
            "name": "Enfield",
            "county": "Greater London"
        },

        {
            "name": "Epping",
            "county": "Essex"
        },

        {
            "name": "Epsom and Ewell",
            "county": "Surrey"
        },

        {
            "name": "Epworth",
            "county": "Lincolnshire"
        },

        {
            "name": "Erith",
            "county": "Greater London"
        },

        {
            "name": "Eton",
            "county": "Berkshire"
        },

        {
            "name": "Evesham",
            "county": "Worcestershire"
        },

        {
            "name": "Exmouth",
            "county": "Devon"
        },

        {
            "name": "Eye",
            "county": "Suffolk"
        },

        ////
        ////
        //F
        ////
        ////

        {
            "name": "Fairford",
            "county": "Gloucestershire"
        },

        {
            "name": "Fakenham",
            "county": "Norfolk"
        },

        {
            "name": "Falmouth",
            "county": "Cornwall"
        },

        {
            "name": "Fareham",
            "county": "Hampshire"
        },

        {
            "name": "Faringdon",
            "county": "Oxfordshire"
        },

        {
            "name": "Farnborough",
            "county": "Hampshire"
        },

        {
            "name": "Farnham",
            "county": "Surrey"
        },

        {
            "name": "Faversham",
            "county": "Kent"
        },

        {
            "name": "Fazeley",
            "county": "Staffordshire"
        },

        {
            "name": "Featherstone",
            "county": "West Yorkshire"
        },

        {
            "name": "Felixstowe",
            "county": "Suffolk"
        },

        {
            "name": "Ferndown",
            "county": "Dorset"
        },

        {
            "name": "Ferryhill",
            "county": "Durham"
        },

        {
            "name": "Filey",
            "county": "North Yorkshire"
        },

        {
            "name": "Filton",
            "county": "Gloucestershire"
        },

        {
            "name": "Finchley",
            "county": "Greater London"
        },

        {
            "name": "Fleet",
            "county": "Hampshire"
        },

        {
            "name": "Fleetwood",
            "county": "Lancashire"
        },

        {
            "name": "Flitwick",
            "county": "Bedfordshire"
        },

        {
            "name": "Folkestone",
            "county": "Kent"
        },

        {
            "name": "Fordbridge",
            "county": "West Midlands"
        },

        {
            "name": "Fordingbridge",
            "county": "Hampshire"
        },

        {
            "name": "Fordwich",
            "county": "Kent"
        },

        {
            "name": "Fowey",
            "county": "Cornwall"
        },
        {
            "name": "Framlingham",
            "county": "Suffolk"
        },
        {
            "name": "Frinton and Walton",
            "county": "Essex"
        },
        {
            "name": "Frodsham",
            "county": "Cheshire"
        },
        {
            "name": "Frome",
            "county": "Somerset"
        },

        ////
        ////
        //G
        ////
        ////


        {
            "name": "Gainsborough",
            "county": "Lincolnshire"
        },
        {
            "name": "Garstang",
            "county": "Lancashire"
        },
        {
            "name": "Gateshead",
            "county": "Tyne and Wear"
        },
        {
            "name": "Gillingham",
            "county": "Dorset"
        },
        {
            "name": "Gillingham",
            "county": "Kent"
        },
        {
            "name": "Glastonbury",
            "county": "Somerset"
        },
        {
            "name": "Glossop",
            "county": "Derbyshire"
        },
        {
            "name": "Godalming",
            "county": "Surrey"
        },
        {
            "name": "Godmanchester",
            "county": "Cambridgeshire"
        },
        {
            "name": "Goole",
            "county": "East Riding of Yorkshire"
        },
        {
            "name": "Gorleston-on-Sea",
            "county": "Norfolk"
        },
        {
            "name": "Gosport",
            "county": "Hampshire"
        },
        {
            "name": "Grange-over-Sands",
            "county": "Cumbria"
        },
        {
            "name": "Grantham",
            "county": "Lincolnshire"
        },
        {
            "name": "Grassington",
            "county": "North Yorkshire"
        },
        {
            "name": "Gravesend",
            "county": "Kent"
        },
        {
            "name": "Grays",
            "county": "Essex"
        },
        {
            "name": "Great Dunmow",
            "county": "Essex"
        },
        {
            "name": "Great Torrington",
            "county": "Devon"
        },
        {
            "name": "Great Yarmouth",
            "county": "Norfolk"
        },
        {
            "name": "Greater Willington",
            "county": "Durham"
        },
        {
            "name": "Grimsby",
            "county": "Lincolnshire"
        },
        {
            "name": "Guildford",
            "county": "Surrey"
        },
        {
            "name": "Guisborough",
            "county": "North Yorkshire"
        },
        ////
        ////
        //H
        ////
        ////
        {
            "name": "Hadleigh",
            "county": "Suffolk"
        },
        {
            "name": "Hailsham",
            "county": "East Sussex"
        },
        {
            "name": "Halesowen",
            "county": "West Midlands"
        },
        {
            "name": "Halesworth",
            "county": "Suffolk"
        },
        {
            "name": "Halewood",
            "county": "Merseyside"
        },
        {
            "name": "Halifax",
            "county": "West Yorkshire"
        },
        {
            "name": "Halstead",
            "county": "Essex"
        },
        {
            "name": "Haltwhistle",
            "county": "Northumberland"
        },
        {
            "name": "Redenhall with Harleston",
            "county": "Norfolk"
        },
        {
            "name": "Harlow",
            "county": "Essex"
        },
        {
            "name": "Harpenden",
            "county": "Hertfordshire"
        },
        {
            "name": "Harrogate",
            "county": "North Yorkshire"
        },
        {
            "name": "Harrow",
            "county": "Greater London"
        },
        {
            "name": "Hartland",
            "county": "Devon"
        },
        {
            "name": "Hartlepool",
            "county": "Durham"
        },
        {
            "name": "Harwich",
            "county": "Essex"
        },
        {
            "name": "Harworth and Bircotes",
            "county": "Nottinghamshire"
        },
        {
            "name": "Haslemere",
            "county": "Surrey"
        },
        {
            "name": "Haslingden",
            "county": "Lancashire"
        },
        {
            "name": "Hastings",
            "county": "East Sussex"
        },
        {
            "name": "Hatfield",
            "county": "Hertfordshire"
        },
        {
            "name": "Hatfield",
            "county": "South Yorkshire"
        },
        {
            "name": "Hatherleigh",
            "county": "Devon"
        },
        {
            "name": "Havant",
            "county": "Hampshire"
        },
        {
            "name": "Haverhill",
            "county": "Suffolk"
        },
        {
            "name": "Hawkinge",
            "county": "Kent"
        },
        {
            "name": "Haxby",
            "county": "North Yorkshire"
        },
        {
            "name": "Hawes",
            "county": "North Yorkshire"
        },
        {
            "name": "Hayes",
            "county": "Greater London"
        },
        {
            "name": "Hayle",
            "county": "Cornwall"
        },
        {
            "name": "Haywards Heath",
            "county": "West Sussex"
        },
        {
            "name": "Heanor and Loscoe",
            "county": "Derbyshire"
        },
        {
            "name": "Heathfield",
            "county": "East Sussex"
        },
        {
            "name": "Hebden Royd",
            "county": "West Yorkshire"
        },
        {
            "name": "Hedge End",
            "county": "Hampshire"
        },
        {
            "name": "Hednesford",
            "county": "Staffordshire"
        },
        {
            "name": "Hedon",
            "county": "East Riding of Yorkshire"
        },
        {
            "name": "Helmsley",
            "county": "North Yorkshire"
        },
        {
            "name": "Helston",
            "county": "Cornwall"
        },
        {
            "name": "Hemel Hempstead",
            "county": "Hertfordshire"
        },
        {
            "name": "Hemsworth",
            "county": "West Yorkshire"
        },
        {
            "name": "Hendon",
            "county": "Greater London"
        },
        {
            "name": "Henley-in-Arden",
            "county": "Warwickshire"
        },
        {
            "name": "Henley-on-Thames",
            "county": "Oxfordshire"
        },
        {
            "name": "Hertford",
            "county": "Hertfordshire"
        },
        {
            "name": "Hessle",
            "county": "East Riding of Yorkshire"
        },
        {
            "name": "Hetton",
            "county": "Tyne and Wear"
        },
        {
            "name": "Hexham",
            "county": "Northumberland"
        },
        {
            "name": "Heywood",
            "county": "Greater Manchester"
        },
        {
            "name": "Higham Ferrers",
            "county": "Northamptonshire"
        },
        {
            "name": "Highbridge",
            "county": "Somerset"
        },
        {
            "name": "Highworth",
            "county": "Wiltshire"
        },
        {
            "name": "High Wycombe",
            "county": "Buckinghamshire"
        },
        {
            "name": "Hinckley",
            "county": "Leicestershire"
        },
        {
            "name": "Hingham",
            "county": "Norfolk"
        },
        {
            "name": "Hitchin",
            "county": "Hertfordshire"
        },
        {
            "name": "Hoddesdon",
            "county": "Hertfordshire"
        },
        {
            "name": "Holbeach",
            "county": "Lincolnshire"
        },
        {
            "name": "Holsworthy",
            "county": "Devon"
        },
        {
            "name": "Holt",
            "county": "Norfolk"
        },
        {
            "name": "Honiton",
            "county": "Devon"
        },
        {
            "name": "Horley",
            "county": "Surrey"
        },
        {
            "name": "Horncastle",
            "county": "Lincolnshire"
        },
        {
            "name": "Hornsea",
            "county": "East Riding of Yorkshire"
        },
        {
            "name": "Hornsey",
            "county": "Greater London"
        },
        {
            "name": "Horsforth",
            "county": "West Yorkshire"
        },
        {
            "name": "Horsham",
            "county": "West Sussex"
        },
        {
            "name": "Horwich",
            "county": "Greater Manchester"
        },
        {
            "name": "Houghton Regis",
            "county": "Bedfordshire"
        },
        {
            "name": "Hounslow",
            "county": "Greater London"
        },
        {
            "name": "Howden",
            "county": "East Riding of Yorkshire"
        },
        {
            "name": "Huddersfield",
            "county": "West Yorkshire"
        },
        {
            "name": "Hungerford",
            "county": "Berkshire"
        },
        {
            "name": "Hunstanton",
            "county": "Norfolk"
        },
        {
            "name": "Huntingdon",
            "county": "Cambridgeshire"
        },
        {
            "name": "Hyde",
            "county": "Greater Manchester"
        },
        {
            "name": "Hythe",
            "county": "Kent"
        },
        ////
        ////
        //I
        ////
        ////
        {
            "name": "Ilford",
            "county": "Greater London"
        },
        {
            "name": "Ilfracombe",
            "county": "Devon"
        },
        {
            "name": "Ilkeston",
            "county": "Derbyshire"
        },
        {
            "name": "Ilkley",
            "county": "West Yorkshire"
        },
        {
            "name": "Ilminster",
            "county": "Somerset"
        },
        {
            "name": "Immingham",
            "county": "Lincolnshire"
        },
        {
            "name": "Ingleby Barwick",
            "county": "North Yorkshire"
        },
        {
            "name": "Ipswich",
            "county": "Suffolk"
        },
        {
            "name": "Irthlingborough",
            "county": "Northamptonshire"
        },
        {
            "name": "Ivybridge",
            "county": "Devon"
        },
        ////
        ////
        //J
        ////
        ////
        {
            "name": "Jarrow",
            "county": "Tyne and Wear"
        },
        ////
        ////
        //K
        ////
        ////
        {
            "name": "Keighley",
            "county": "West Yorkshire"
        },
        {
            "name": "Kempston",
            "county": "Bedfordshire"
        },
        {
            "name": "Kendal",
            "county": "Cumbria"
        },
        {
            "name": "Kenilworth",
            "county": "Warwickshire"
        },
        {
            "name": "Kesgrave",
            "county": "Suffolk"
        },
        {
            "name": "Keswick",
            "county": "Cumbria"
        },
        {
            "name": "Kettering",
            "county": "Northamptonshire"
        },
        {
            "name": "Keynsham",
            "county": "Somerset"
        },
        {
            "name": "Kidderminster",
            "county": "Worcestershire"
        },
        {
            "name": "Kidsgrove",
            "county": "Staffordshire"
        },
        {
            "name": "Kimberley",
            "county": "Nottinghamshire"
        },
        {
            "name": "King's Lynn",
            "county": "Norfolk"
        },
        {
            "name": "Kingsbridge",
            "county": "Devon"
        },
        {
            "name": "Kingsteignton",
            "county": "Devon"
        },
        {
            "name": "Kingston-upon-Thames",
            "county": "Greater London"
        },
        {
            "name": "Kington",
            "county": "Herefordshire"
        },
        {
            "name": "Kirkby-in-Ashfield",
            "county": "Nottinghamshire"
        },
        {
            "name": "Kirkby Lonsdale",
            "county": "Cumbria"
        },
        {
            "name": "Kirkby Stephen",
            "county": "Cumbria"
        },
        {
            "name": "Kirkbymoorside",
            "county": "North Yorkshire"
        },
        {
            "name": "Kirkham",
            "county": "Lancashire"
        },
        {
            "name": "Kirton-in-Lindsey",
            "county": "Lincolnshire"
        },
        {
            "name": "Knaresborough",
            "county": "North Yorkshire"
        },
        {
            "name": "Knutsford",
            "county": "Cheshire"
        },
        ////L
        {
            "name": "Langport",
            "county": "Somerset"
        },
        {
            "name": "Launceston",
            "county": "Cornwall"
        },
        {
            "name": "Leatherhead",
            "county": "Surrey"
        },
        {
            "name": "Lechlade",
            "county": "Gloucestershire"
        },
        {
            "name": "Ledbury",
            "county": "Herefordshire"
        },
        {
            "name": "Leek",
            "county": "Staffordshire"
        },
        {
            "name": "Leigh",
            "county": "Greater Manchester"
        },
        {
            "name": "Leighton-Linslade",
            "county": "Bedfordshire"
        },
        {
            "name": "Leigh-on-Sea",
            "county": "Essex"
        },
        {
            "name": "Leiston",
            "county": "Suffolk"
        },
        {
            "name": "Leominster",
            "county": "Herefordshire"
        },
        {
            "name": "Letchworth Garden City",
            "county": "Herefordshire"
        },
        {
            "name": "Lewes",
            "county": "East Sussex"
        },
        {
            "name": "Leyburn",
            "county": "North Yorkshire"
        },
        {
            "name": "Leyland",
            "county": "Lancashire"
        },
        {
            "name": "Leyton",
            "county": "Greater London"
        },
        {
            "name": "Liskeard",
            "county": "Cornwall"
        },
        {
            "name": "Littlehampton",
            "county": "West Sussex"
        },
        {
            "name": "Loddon",
            "county": "Norfolk"
        },
        {
            "name": "Loftus",
            "county": "North Yorkshire"
        },
        {
            "name": "Long Sutton",
            "county": "Lincolnshire"
        },
        {
            "name": "Longridge",
            "county": "Lancashire"
        },
        {
            "name": "Longtown",
            "county": "Cumbria"
        },
        {
            "name": "Looe",
            "county": "Cornwall"
        },
        {
            "name": "Lostwithiel",
            "county": "Cornwall"
        },
        {
            "name": "Loughborough",
            "county": "Leicestershire"
        },
        {
            "name": "Loughton",
            "county": "Essex"
        },
        {
            "name": "Louth",
            "county": "Lincolnshire"
        },
        {
            "name": "Lowestoft",
            "county": "Suffolk"
        },
        {
            "name": "Ludgershall",
            "county": "Wiltshire"
        },
        {
            "name": "Ludlow",
            "county": "Shropshire"
        },
        {
            "name": "Luton",
            "county": "Bedfordshire"
        },
        {
            "name": "Lutterworth",
            "county": "Leicestershire"
        },
        {
            "name": "Lydd",
            "county": "Kent"
        },
        {
            "name": "Lydney",
            "county": "Gloucestershire"
        },
        {
            "name": "Lyme Regis",
            "county": "Dorset"
        },
        {
            "name": "Lymington",
            "county": "Hampshire"
        },
        {
            "name": "Lynton & Lynmouth",
            "county": "Devon"
        },
        {
            "name": "Lytchett Minster & Upton",
            "county": "Dorset"
        },
        {
            "name": "Lytham St Annes",
            "county": "Lancashire"
        },
        ////m
        {
            "name": "Mablethorpe and Sutton",
            "county": "Lincolnshire"
        },
        {
            "name": "Macclesfield",
            "county": "Cheshire"
        },
        {
            "name": "Madeley",
            "county": "Shropshire"
        },
        {
            "name": "Maghull",
            "county": "Merseyside"
        },
        {
            "name": "Maidenhead",
            "county": "Berkshire"
        },
        {
            "name": "Maidstone",
            "county": "Kent"
        },
        {
            "name": "Maldon",
            "county": "Essex"
        },
        {
            "name": "Malmesbury",
            "county": "Wiltshire"
        },
        {
            "name": "Maltby",
            "county": "South Yorkshire"
        },
        {
            "name": "Malton",
            "county": "North Yorkshire"
        },
        {
            "name": "Malvern",
            "county": "Worcestershire"
        },
        {
            "name": "Manningtree",
            "county": "Essex"
        },
        {
            "name": "Mansfield",
            "county": "Nottinghamshire"
        },
        {
            "name": "Marazion",
            "county": "Cornwall"
        },
        {
            "name": "March",
            "county": "Cambridgeshire"
        },
        {
            "name": "Margate",
            "county": "Kent"
        },
        {
            "name": "Market Bosworth",
            "county": "Leicestershire"
        },
        {
            "name": "Market Deeping",
            "county": "Lincolnshire"
        },
        {
            "name": "Market Drayton",
            "county": "Shropshire"
        },
        {
            "name": "Market Harborough",
            "county": "Leicestershire"
        },
        {
            "name": "Market Rasen",
            "county": "Lincolnshire"
        },
        {
            "name": "Market Weighton",
            "county": "East Riding of Yorkshire"
        },
        {
            "name": "Marlborough",
            "county": "Wiltshire"
        },
        {
            "name": "Marlow",
            "county": "Buckinghamshire"
        },
        {
            "name": "Maryport",
            "county": "Cumbria"
        },
        {
            "name": "Masham",
            "county": "North Yorkshire"
        },
        {
            "name": "Matlock",
            "county": "Derbyshire"
        },
        {
            "name": "Medlar-with-Wesham",
            "county": "Lancashire"
        },
        {
            "name": "Melksham",
            "county": "Wiltshire"
        },
        {
            "name": "Meltham",
            "county": "West Yorkshire"
        },
        {
            "name": "Melton Mowbray",
            "county": "Leicestershire"
        },
        {
            "name": "Mere",
            "county": "Wiltshire"
        },
        {
            "name": "Mexborough",
            "county": "South Yorkshire"
        },
        {
            "name": "Middleham",
            "county": "North Yorkshire"
        },
        {
            "name": "Middlesbrough",
            "county": "North Yorkshire"
        },
        {
            "name": "Middleton",
            "county": "Greater Manchester"
        },
        {
            "name": "Middlewich",
            "county": "Cheshire"
        },
        {
            "name": "Midhurst",
            "county": "West Sussex"
        },
        {
            "name": "Midsomer Norton",
            "county": "Somerset"
        },
        {
            "name": "Mildenhall",
            "county": "Suffolk"
        },
        {
            "name": "Millom",
            "county": "Cumbria"
        },
        {
            "name": "Minchinhampton",
            "county": "Gloucestershire"
        },
        {
            "name": "Minehead",
            "county": "Somerset"
        },
        {
            "name": "Minster",
            "county": "Kent"
        },
        {
            "name": "Mirfield",
            "county": "West Yorkshire"
        },
        {
            "name": "Mitcham",
            "county": "Greater London"
        },
        {
            "name": "Mitcheldean",
            "county": "Gloucestershire"
        },
        {
            "name": "Modbury",
            "county": "Devon"
        },
        {
            "name": "Morecambe",
            "county": "Lancashire"
        },
        {
            "name": "Moretonhampstead",
            "county": "Devon"
        },
        {
            "name": "Moreton-in-Marsh",
            "county": "Gloucestershire"
        },
        {
            "name": "Morley",
            "county": "West Yorkshire"
        },
        {
            "name": "Morpeth",
            "county": "Northumberland"
        },
        {
            "name": "Mossley",
            "county": "Greater Manchester"
        },
        {
            "name": "Much Wenlock",
            "county": "Shropshire"
        },
        /////n
        {
            "name": "Nailsea",
            "county": "Somerset"
        },
        {
            "name": "Nailsworth",
            "county": "Gloucestershire"
        },
        {
            "name": "Nantwich",
            "county": "Cheshire"
        },
        {
            "name": "Needham Market",
            "county": "Suffolk"
        },
        {
            "name": "Nelson",
            "county": "Lancashire"
        },
        {
            "name": "Neston",
            "county": "Cheshire"
        },
        {
            "name": "New Alresford",
            "county": "Hampshire"
        },
        {
            "name": "New Mills",
            "county": "Derbyshire"
        },
        {
            "name": "New Milton",
            "county": "Hampshire"
        },
        {
            "name": "New Romney",
            "county": "Kent"
        },
        {
            "name": "Newark-on-Trent",
            "county": "Nottinghamshire"
        },
        {
            "name": "Newbiggin-by-the-Sea",
            "county": "Northumberland"
        },
        {
            "name": "Newbury",
            "county": "Berkshire"
        },
        {
            "name": "Newcastle-under-Lyme",
            "county": "Staffordshire"
        },
        {
            "name": "Newent",
            "county": "Gloucestershire"
        },
        {
            "name": "Newhaven",
            "county": "East Sussex"
        },
        {
            "name": "Newlyn",
            "county": "Cornwall"
        },
        {
            "name": "Newmarket",
            "county": "Suffolk"
        },
        {
            "name": "Newport",
            "county": "Isle of Wight"
        },
        {
            "name": "Newport",
            "county": "Shropshire"
        },
        {
            "name": "Newport Pagnell",
            "county": "Buckinghamshire"
        },
        {
            "name": "Newquay",
            "county": "Cornwall"
        },
        {
            "name": "Newton Abbot",
            "county": "Devon"
        },
        {
            "name": "Newton Aycliffe",
            "county": "County Durham"
        },
        {
            "name": "Newton-le-Willows",
            "county": "Merseyside"
        },
        {
            "name": "Normanton",
            "county": "West Yorkshire"
        },
        {
            "name": "North Hykeham",
            "county": "Lincolnshire"
        },
        {
            "name": "North Petherton",
            "county": "Somerset"
        },
        {
            "name": "North Tawton",
            "county": "Devon"
        },
        {
            "name": "North Walsham",
            "county": "Norfolk"
        },
        {
            "name": "Northallerton",
            "county": "North Yorkshire"
        },
        {
            "name": "Northam",
            "county": "Devon"
        },
        {
            "name": "Northampton",
            "county": "Northamptonshire"
        },
        {
            "name": "Northfleet",
            "county": "Kent"
        },
        {
            "name": "Northleach with Eastington",
            "county": "Gloucestershire"
        },
        {
            "name": "Northwich",
            "county": "Cheshire"
        },
        {
            "name": "Norton-on-Derwent",
            "county": "North Yorkshire"
        },
        {
            "name": "Nuneaton",
            "county": "Warwickshire"
        },
        ////o
        {
            "name": "Oakengates",
            "county": "Shropshire"
        },
        {
            "name": "Oakham",
            "county": "Rutland"
        },
        {
            "name": "Okehampton",
            "county": "Devon"
        },
        {
            "name": "Oldbury",
            "county": "West Midlands"
        },
        {
            "name": "Oldham",
            "county": "Greater Manchester"
        },
        {
            "name": "Ollerton and Boughton",
            "county": "Nottinghamshire"
        },
        {
            "name": "Olney",
            "county": "Buckinghamshire"
        },
        {
            "name": "Ongar",
            "county": "Essex"
        },
        {
            "name": "Orford",
            "county": "Suffolk"
        },
        {
            "name": "Ormskirk",
            "county": "Lancashire"
        },
        {
            "name": "Orpington",
            "county": "Greater London"
        },
        {
            "name": "Ossett",
            "county": "West Yorkshire"
        },
        {
            "name": "Oswestry",
            "county": "Shropshire"
        },
        {
            "name": "Otley",
            "county": "West Yorkshire"
        },
        {
            "name": "Ottery St Mary",
            "county": "Devon"
        },
        {
            "name": "Oundle",
            "county": "Northamptonshire"
        }]
}
