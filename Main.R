install.packages('stars')
install.packages('ggmap')
install.packages('osmdata')
install.packages('geojsonio')
install.packages('plotly')
library(stars)
library(plotly)
library(ggplot2)
library(ggmap)
library(osmdata)
library(geojsonio)
library(dplyr)

dtm_harv = read_stars("data/neon-geospatial-data/HARV/HARV_dtmCrop.tif")
dtm_harv

ggplot() + 
  geom_stars(data = dtm_harv) +
  scale_fill_viridis_c()

ggmap::register_google(key = "AIzaSyAq4_-L4-N_NtSK1mY6ddul0QBRH6sev0E", write = TRUE)

point_df <- round(data.frame(
  x = jitter(rep(-74, 10), amount = 0.05),
  y = jitter(rep(40.74, 10), amount = 0.05)
), digits = 2)
head(point_df)

forPath <- data.frame(
  x = c(-74.01, -74.03),
  y = c(40.74, 40.76)
)
forPath

get_googlemap(c(lon = -70,lat = 0), zoom = 3, maptype = "terrain", path = forPath, markers = point_df) %>%
  ggmap()

NewYork_map = get_map(c(lon = -70,lat = 0), zoom = 3, maptype = "terrain")

ggmap(NewYork_map) +
  geom_point(data = point_df, aes(x=x, y=y), color = "red", size = 3) +
  geom_path(data = forPath, aes(x=x, y=y), color = "blue", size = 2) 


airport_df <- geojson_read("data/airports_2020.geojson", what = "sp")
dim(airport_df)
View(head(airport_df[c('latitude_d','longitude_')]))
View(head(point_df))

xx = data.frame(
  lon = airport_df$longitude_,
  lat = airport_df$latitude_d)

xx

b = data.frame(
  lat = c(-9.4280004501343004),
  lon = c(160.05499267578)
)
b

World_map = get_map('klang', zoom = 10, maptype = "roadmap", scale = 4)

ggplotly(
  ggmap(World_map) +
    geom_point(data = xx, aes(y=lat, x=lon), color = "red", size = 1)
)

#building
file = read.csv("C:\\Users\\TUF\\Downloads\\305_buildings.csv\\305_buildings.csv",header=TRUE)
View(head(file))
file = file[c('latitude','longitude')]
#write.csv(file, file = "C:\\Users\\TUF\\Downloads\\31d_buildings.csv\\31b_buildings_done.csv")

#sample_building = read.csv("C:\\Users\\TUF\\Downloads\\31d_buildings.csv\\31d_buildings_done.csv",header=TRUE)
#sample 1% data
file = file[sample(1:nrow(file), 0.01*nrow(file)), ]
write.csv(file, file = "C:\\Users\\TUF\\Downloads\\305_buildings.csv\\305_buildings_done_1percent.csv")



#API da
cow = read.csv("C:\\Users\\TUF\\Downloads\\APIMS-final.csv\\APIMS-final.csv",header=TRUE)
cow$Time = strptime(cow$Time, format = "%d-%m-%y %H:%M")
cow$Time = format(cow$Time, "%Y")
  #cow$Time = substr(cow$Time, 1, 4)
cow$Time = as.integer(cow$Time)
cow = as.data.frame(lapply(cow, as.integer))

zz = subset(cow, Time == 2020)
meat = round(colMeans(zz, na.rm = TRUE), digits = 0)
meat = data.frame(meat)
View(meat)


#----------------------------------------------------------------
#geocode
library(ggmap)
register_google(key = "AIzaSyAq4_-L4-N_NtSK1mY6ddul0QBRH6sev0E")

hold_coor = data.frame()
hold_coors = data.frame()
for (i in 2:nrow(meat)) {
  location = paste(rownames(meat)[i], ", Malaysia")
  coor = geocode(location = location, output = "latlon")
  hold_coor = rbind(hold_coor, cbind(location, coor))
}
View(hold_coor)

meat = data.frame(meat[-1,]) #remove the year row
hold_coors = cbind(hold_coor, meat)
hold_coors = cbind(hold_coors, meat)
#change column name
colnames(hold_coors)[4] = "api"
  # remove east malaysia
hold_coors = subset(hold_coors, hold_coors$lon < 105)

write.csv(hold_coors, file = "C:\\Users\\TUF\\Downloads\\APIMS-final.csv\\2019_API_index_65_city_Malaysia.csv")

#------------------
#traffic
traffic = read.csv("C:\\Users\\TUF\\Downloads\\traffic.csv",header=TRUE)
View(traffic)

#----------------------------------------------------------
#*#interpolate kriging
broo = read.csv("C:\\Users\\TUF\\Downloads\\APIMS-final.csv\\z_interp_traffic_2019.csv")

  #this because dk why missing 1 row
beeee = c(2.711348778703531934e+04,2.664017910074302563e+04,2.618413788456973998e+04,2.571862054931668536e+04,2.524659244019183461e+04,2.478228161895139419e+04,2.432849076478609277e+04,2.388825283779798701e+04,2.346471498063186664e+04,2.306097438972777309e+04,2.267987645791621253e+04,2.232379831490786455e+04,2.199490100267504022e+04,2.169423705609475292e+04,2.142133257674127890e+04,2.117561516202083658e+04,2.095620187498644009e+04,2.076438268865023929e+04,2.060108816037533325e+04,2.046716928633018324e+04,2.036431489964526190e+04,2.029483633982473475e+04,2.026111415914636018e+04,2.026475077517042519e+04,2.030552956748826909e+04,2.038030672475042229e+04,2.048197796484412538e+04,2.059873604078351855e+04,2.071406171830023959e+04,2.080830387655296727e+04,2.086311328249927465e+04,2.087107744579573773e+04,2.086390351561697025e+04,2.095674752145754974e+04,2.122790632667278987e+04,2.191396797344244987e+04,2.336998626901532771e+04,2.565748196443024062e+04,2.789162868510002954e+04,2.860256528162301765e+04,2.762820548856811365e+04,2.733958811729314039e+04,2.877013353605032535e+04,3.004818527858890593e+04,3.033964362156232892e+04,3.011017052082547161e+04,2.976164867389348728e+04)
broo = rbind(beeee, broo)
View(broo)

#this because the z-interp is plot upside down, bottom row should be top row, vice versa, column is correct
terbalik = data.frame()
for (i in nrow(broo):1){
  terbalik = rbind(terbalik,print(broo[i,]))
}
View(terbalik)

  #write.csv(terbalik, file = "C:\\Users\\TUF\\Downloads\\2867place_temperature_2019.csv")



#automate insert 41 column from 2244place_terbalik_2019.csv to 2244place_2019.csv
  #terbalik = read.csv("C:\\Users\\TUF\\Downloads\\2867place_temperature_2019.csv")
target_file = read.csv("C:\\Users\\TUF\\Downloads\\2867_holdplace.csv")
  #remove first column
#terbalik = terbalik[-1]

hold_api = data.frame()
for ( i in 1:47){
  for ( j in 1:61){
    hold_api = rbind(hold_api, terbalik[j,i])
    #print(terbalik[j,i])
  }
}
done = data.frame()
done = cbind(target_file, hold_api)
colnames(done)[8] = "traffic_2019"
write.csv(done, file = "C:\\Users\\TUF\\Downloads\\2867_holdplace_traffic_2019.csv")


#vegetation part 2 (take grid and group into 966)
borrow = read.csv("C:\\Users\\TUF\\Downloads\\grided_2018traffic.csv")
borrow = borrow %>% group_by(id,left,top,right,bottom,row_index,col_index) %>% 
  summarize(traffic_2018 =mean(traffic_2018))

ididi = c(1,2,3,4,12,47,48,49,50,57,58,94,95,96,97,98,99,100,101,102,103,104,105,106,107,140,141,142,143,144,145,146,147,148,149,150,151,152,153,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,203,204,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,279,280,281,282,283,284,285,286,287,288,289,290,291,292,293,294,295,296,297,298,299,300,326,327,328,329,330,331,332,333,334,335,336,337,338,339,340,341,342,343,344,345,346,347,372,373,374,375,377,378,379,380,381,382,383,384,385,386,387,388,389,390,391,392,393,394,395,423,424,425,426,427,428,429,430,431,432,433,434,435,436,437,438,439,440,441,470,471,472,473,474,475,476,477,478,479,480,481,482,483,484,485,486,487,488,489,491,492,514,515,516,517,518,519,520,521,522,523,524,525,526,527,528,529,530,531,532,533,534,535,536,537,538,560,561,562,563,564,565,566,567,568,569,570,571,572,573,574,575,576,577,578,579,580,581,582,583,584,585,605,606,607,608,609,610,611,612,613,614,615,616,617,618,619,620,621,622,623,624,625,626,627,628,629,630,631,632,652,653,654,655,656,657,658,659,660,661,662,663,664,665,666,667,668,669,670,671,672,673,674,675,676,677,678,698,699,700,701,702,703,704,705,706,707,708,709,710,711,712,713,714,715,716,717,718,719,720,721,722,723,724,744,745,746,747,748,749,750,751,752,753,754,755,756,757,758,759,760,761,762,763,764,765,766,767,768,769,770,771,772,789,790,791,792,793,794,795,796,797,798,799,800,801,802,803,804,805,806,807,808,809,810,811,812,813,814,815,816,817,818,833,834,835,836,837,838,839,840,841,842,843,844,845,846,847,848,849,850,851,852,853,854,855,856,857,858,859,860,861,862,863,864,865,878,879,880,881,882,883,884,885,886,887,888,889,890,891,892,893,894,895,896,897,898,899,900,901,902,903,904,905,906,907,908,909,910,911,925,926,927,928,929,930,931,932,933,934,935,936,937,938,939,940,941,942,943,944,945,946,947,948,949,950,951,952,953,954,955,956,957,958,971,972,973,974,975,976,977,978,979,980,981,982,983,984,985,986,987,988,989,990,991,992,993,994,995,996,997,998,999,1000,1001,1002,1003,1004,1019,1020,1021,1022,1023,1024,1025,1026,1027,1028,1029,1030,1031,1032,1033,1034,1035,1036,1037,1038,1039,1040,1041,1042,1043,1044,1045,1046,1047,1048,1049,1050,1051,1066,1067,1068,1069,1070,1071,1072,1073,1074,1075,1076,1077,1078,1079,1080,1081,1082,1083,1084,1085,1086,1087,1088,1089,1090,1091,1092,1093,1094,1095,1096,1097,1113,1114,1115,1116,1117,1118,1119,1120,1121,1122,1123,1124,1125,1126,1127,1128,1129,1130,1131,1132,1133,1134,1135,1136,1137,1138,1139,1140,1141,1142,1143,1144,1145,1159,1160,1161,1162,1163,1164,1165,1166,1167,1168,1169,1170,1171,1172,1173,1174,1175,1176,1177,1178,1179,1180,1181,1182,1183,1184,1185,1186,1187,1188,1189,1190,1206,1207,1208,1209,1210,1211,1212,1213,1214,1215,1216,1217,1218,1219,1220,1221,1222,1223,1224,1225,1226,1227,1228,1229,1230,1231,1232,1233,1234,1235,1236,1237,1252,1253,1254,1255,1256,1257,1258,1259,1260,1261,1262,1263,1264,1265,1266,1267,1268,1269,1270,1271,1272,1273,1274,1275,1276,1277,1278,1279,1280,1281,1282,1283,1300,1301,1302,1303,1304,1305,1306,1307,1308,1309,1310,1311,1312,1313,1314,1315,1316,1317,1318,1319,1320,1321,1322,1323,1324,1325,1326,1327,1328,1329,1330,1347,1348,1349,1350,1351,1352,1353,1354,1355,1356,1357,1358,1359,1360,1361,1362,1363,1364,1365,1366,1367,1368,1369,1370,1371,1372,1373,1374,1375,1376,1394,1395,1396,1397,1398,1399,1400,1401,1402,1403,1404,1405,1406,1407,1408,1409,1410,1411,1412,1413,1414,1415,1416,1417,1418,1419,1420,1421,1422,1423,1442,1443,1444,1445,1446,1447,1449,1452,1453,1454,1455,1456,1457,1458,1459,1460,1461,1462,1463,1464,1465,1466,1467,1468,1469,1470,1492,1493,1505,1506,1507,1508,1509,1510,1511,1512,1513,1514,1515,1516,1517,1552,1553,1554,1555,1556,1557,1558,1559,1560,1561,1562,1563,1599,1600,1601,1602,1603,1604,1605,1606,1607,1608,1645,1646,1647,1648,1649,1650,1651,1652,1653,1693,1694,1695,1696,1697,1698,1699,1700,1701,1741,1742,1743,1744,1745,1789,1790,1791,1792,1793,1836,1837,1838)
borrow = subset(borrow,borrow$id %in% ididi)
write.csv(borrow,file="C:\\Users\\TUF\\Downloads\\grided_2018trafficFinal.csv")


#Cleaning finally
SUPERSET = read.csv("C:\\Users\\TUF\\Downloads\\nice_New_superset_api_18_19i.csv")
SUPERSET = SUPERSET %>% subset(is.na(windspeed_2019)==FALSE)
write.csv(SUPERSET, file = "C:\\Users\\TUF\\Downloads\\SUPERSET_backup.csv")

SUPERSET = read.csv("C:\\Users\\TUF\\Downloads\\FINAL_SUPERSET.csv")
SUPERSET =SUPERSET %>% mutate_all(~if_else(is.na(.),NA,as.character(.)))
write.csv(SUPERSET, file = "C:\\Users\\TUF\\Downloads\\SUPERSET22.csv")

#-------------------------------------------
#no need run, for make the superset nice only
heyyy = read.csv("C:\\Users\\TUF\\Downloads\\New_superset_api_18_19.csv")
colnames(heyyy)[18] = "mean_api_interporated"

heyyy = heyyy[c("id","left","top","right","bottom","row_index","col_index","Average_Api_interpolated","mean_api_interpolated_2019")] %>% 
            group_by(id,left,top,right,bottom,row_index,col_index,Average_Api_interpolated,mean_api_interpolated_2019) %>% 
            summarize((count =n()))
write.csv(heyyy, file = "C:\\Users\\TUF\\Downloads\\nice_New_superset_api_18_19i.csv")




#see see oni
borrow = read.csv("C:\\Users\\TUF\\Downloads\\allTheMeteo\\Alor.Gajah_rompim , Malaysia 2019-06-01 to 2019-06-30.csv")
View(borrow)
borrow = borrow %>% group_by(name, longitude, latitude) %>% summarize(temp = mean(temp), humidity=mean(humidity),precip=mean(precip),humidity=mean(humidity), windspeed = mean(windspeed))
write.csv(borrow,file="C:\\Users\\TUF\\Downloads\\allTheMeteo\\allDatafor2019.csv")

# altitude
borrow = read.csv("C:\\Users\\TUF\\Downloads\\altitude.csv")
View(borrow)
borrow = borrow %>% group_by(id,left,top,right,bottom,row_index,col_index) %>% 
  summarize(mean_altitude =mean(alt))
write.csv(borrow,file="C:\\Users\\TUF\\Downloads\\altitudeFInal.csv")

#vegetation
borrow = read.csv("C:\\Users\\TUF\\Downloads\\vegetation.csv")
borrow = subset(borrow, borrow$threshold == 30)
write.csv(borrow,file="C:\\Users\\TUF\\Downloads\\vegetation30pervent.csv")

borrow = read.csv("C:\\Users\\TUF\\Downloads\\vegetation30pervent.csv")
borrow = borrow %>% select(c("ï..country",subnational1,subnational2,treecover2018,treecover2019))
View(borrow)
write.csv(borrow,file="C:\\Users\\TUF\\Downloads\\vegetation30perventSelect.csv")



#geocode
register_google(key = "AIzaSyAq4_-L4-N_NtSK1mY6ddul0QBRH6sev0E")

hold_coor = data.frame()
hold_coors = data.frame()
for (i in 1:nrow(borrow)) {
  location = paste(borrow[i,3], ",", borrow[i,2],", Malaysia")
  coor = geocode(location = location, output = "latlon")
  hold_coor = rbind(hold_coor, cbind(location, coor))
}
hold_coors = cbind(hold_coor,borrow[,4:5])
#remove east malaysia
hold_coors = subset(hold_coors, hold_coors$lon < 105)
write.csv(hold_coors,file="C:\\Users\\TUF\\Downloads\\vegetation30perventTOKrige.csv")
