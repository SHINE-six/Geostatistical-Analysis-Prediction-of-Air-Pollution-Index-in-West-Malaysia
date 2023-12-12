**API dataset**
{
    Date: {
        From: 01-10-2005,
        To: 07-05-2022,
        Interval: "twice per day"
    },
    Record: 71459,
    Attribute: 66,
    LocatonType: [LocationName],
    Description: "Air Pollution Index of Whole Malaysia, 65 location as attributes",
    DataSource: "https://www.kaggle.com/datasets/ynshung/malaysia-air-pollution-index"
}

**Meteology**
{
    Date: {
        Page1:{
            From: 01-06-2018,
            To: 30-06-2018,
            Interval: "Once per day",
            Exception: {
                Attribute: "Precipitation",
                Record: "Kuala Terengganu",
                From: 01-01-2018,
                To: 31-12-2018,
                Explanation: "June 2018, Kuala Terengganu, precipitation appear to be outlier, 1.71, among surrounding average of 5.0 to 5.5, thus recapture of Kuala Terengganu, precipitation over 365 days in 2018 is done",
                Changover: "does not direct changes in RawDataSet (Meteo2018), but direct manual cutover in PreparedDataSet (Meteo_18) from value 1.70666666666667 to 5.216164384"
            }
        },
        Page2:{
            From: 01-06-2019,
            To: 30-06-2019,
            Interval: "Once per day"
        }
    },
    Record: 1380,
    Attribute: 7,
    LocationType: [LocationName, Coordinates],
    Description: "Temperature, Humidity, Precipitation, Windspeed for West Malaysia (46 location points)",
    DataSource: "https://www.visualcrossing.com/weather/weather-data-services#"
}

**Altitude**
{
    Record: 1919952,
    Attribute: 3,
    LocationType: [ Coordinates],
    DatePosted: 31-01-2020
    Description: "Altitude in meter for each km square of west malaysia, (not clip)",
    DataSource: "https://figshare.com/articles/dataset/Malaysia_elevation_data/11777646"
}

**Building Count**
{
    Record: NA,
    Attribute: 3,
    LocationType: [Coordinates],
    DatePosted: May-2023,
    Description: "Image processing from satellite to map each potential building, Malaysia divide into 3 area (31b,31d,305), the main dataset too large (GB), thus only sampling 1 percent",
    DataSource: "https://sites.research.google/open-buildings/#dataformat"
}

**Vegetation**
{
    Date: {
        From: 2000,
        To: 2022,
        Interval: "Yearly"
    },
    Record: 1152,
    Attribute: 30,
    LocationType: [LocationName],
    Description: "144 locations in Malaysia, consist of tree cover in 2000 and 2010 in hactare, then more is yearly tree lost",
    DataSource: "https://www.globalforestwatch.org/map/country/MYS/?mainMap=eyJzaG93QW5hbHlzaXMiOnRydWV9&map=eyJjZW50ZXIiOnsibGF0Ijo0LjE5MTg1Mjg3MzQxMzAyNSwibG5nIjoxMDcuMDYyNjgxNDEzNzc5MDJ9LCJ6b29tIjo1Ljk2NTM0MzIwMTM5NDg2NiwiY2FuQm91bmQiOmZhbHNlLCJkYXRhc2V0cyI6W3siZGF0YXNldCI6InBvbGl0aWNhbC1ib3VuZGFyaWVzIiwibGF5ZXJzIjpbImRpc3B1dGVkLXBvbGl0aWNhbC1ib3VuZGFyaWVzIiwicG9saXRpY2FsLWJvdW5kYXJpZXMiXSwib3BhY2l0eSI6MSwidmlzaWJpbGl0eSI6dHJ1ZX0seyJkYXRhc2V0IjoidHJlZS1jb3Zlci1nYWluIiwibGF5ZXJzIjpbInRyZWUtY292ZXItZ2Fpbi0yMDAxLTIwMjAiXSwib3BhY2l0eSI6MSwidmlzaWJpbGl0eSI6dHJ1ZX0seyJkYXRhc2V0IjoidHJlZS1jb3Zlci1sb3NzIiwibGF5ZXJzIjpbInRyZWUtY292ZXItbG9zcyJdLCJvcGFjaXR5IjoxLCJ2aXNpYmlsaXR5Ijp0cnVlLCJ0aW1lbGluZVBhcmFtcyI6eyJzdGFydERhdGUiOiIyMDAxLTAxLTAxIiwiZW5kRGF0ZSI6IjIwMjItMTItMzEiLCJ0cmltRW5kRGF0ZSI6IjIwMjItMTItMzEifX0seyJkYXRhc2V0IjoidHJlZS1jb3ZlciIsImxheWVycyI6WyJ0cmVlLWNvdmVyLTIwMTAiXSwib3BhY2l0eSI6MSwidmlzaWJpbGl0eSI6dHJ1ZX1dfQ%3D%3D&mapPrompts=eyJvcGVuIjp0cnVlLCJzdGVwc0tleSI6InN1YnNjcmliZVRvQXJlYSJ9"
}

**Traffic**
{
    Date:{
        From: 2013,
        To: 2022,
        Interval: yearly
    },
    Record: 63,
    Attribute: 13,
    LocationType: [LocationName],
    Description: "Average Daily Traffic at 63 location in West Malaysia",
    DataSource: "https://www.mot.gov.my/en/Statistik%20Tahunan%20Pengangkutan/Transport%20Statistics%20Malaysia%202022.pdf"
}

**Population**
{
    Date: {
        Page1:{
            From: 2018,
            To: 2018,
            Interval: NA
        },
        Page2:{
            From: 2019,
            To: 2019,
            Interval: NA
        },
        Record: NA,
        Attribute: 3,
        LocationType: [Coordinates],
        Description: "Population count per KM square unit in Malaysia",
        DataSource: "https://data.humdata.org/dataset/worldpop-population-density-for-malaysia"
    }
}
