
import Foundation

//This does nothing and is just a place to leave information and notes
//if removed build will fail.

struct Area {
    let Ide: String
    
    
    static let all: [Area] = [
        Area(Ide:"" ),
        Area(Ide:"Floor 1" ),
        Area(Ide:"Floor 2" ),
        Area(Ide:"Floor 3" ),
        Area(Ide:"Floor 4" ),
        Area(Ide:"Floor 5" ),
        Area(Ide:"Floor 6" ),
        Area(Ide:"Floor 7" ),
    ]
}

extension Area: CustomStringConvertible {
    var description: String {
        return "\(Ide) "
    }
    
    
}
struct Quote {
    let Name: String
    let Description: String
    let IP: String
    
    static let all: [Quote] =  [
        Quote(Name: "", Description: "", IP: "0" ),
        Quote(Name: "SFO1-Stockton", Description: "SFO1-Stockton", IP: "10.251.24.193" ),
        Quote(Name: "SFO1-Lombard", Description: "SFO1-Lombard", IP: "10.251.24.195" ),
        Quote(Name: "SFO2-Market", Description: "SFO2-Market", IP: "10.251.24.197" ),
        Quote(Name: "SFO3-Howard", Description: "SFO3-Howard", IP: "10.251.24.196" ),
        Quote(Name: "SFO7-Spears", Description: "SFO7-Spears", IP: "10.251.24.192" ),
        Quote(Name: "SFO7-Folsom", Description: "SFO7-Folsom", IP: "10.251.24.194" ),
        Quote(Name: "MTV1-Sharks", Description: "MTV1-Sharks", IP: "10.252.31.3" ),
        Quote(Name: "MTV1-Giants", Description: "MTV1-Giants", IP: "10.252.31.4" ),
        Quote(Name: "MTV1-Earthquakes", Description: "MTV1-Earthquakes", IP: "10.252.31.6" ),
        Quote(Name: "MTV2-Warriors", Description: "MTV2-Warriors", IP: "10.252.31.1" ),
        Quote(Name: "MTV2-Raiders", Description: "MTV2-Raiders", IP: "10.252.31.5" ),
        Quote(Name: "TOR-MADCat", Description: "Tor-MADCat", IP: "10.242.24.196" ),
        Quote(Name: "YVR2-West", Description: "YVR2-West", IP: "10.244.24.193" ),
        Quote(Name: "YVR2-East", Description: "YVR2-East", IP: "10.244.24.192" ),
        Quote(Name: "PAR1-Kouign-Amann", Description: "PAR1-Kouign-Amann", IP: "10.243.24.196" ),
        Quote(Name: "PDX3-Wilderness", Description: "PDX3-Wilderness", IP: "10.248.24.191" ),
        Quote(Name: "PDX3-Frontier", Description: "PDX3-Frontier", IP: "10.248.24.192" ),
        Quote(Name: "LON4-Rubbish", Description: "LON4-Rubbish", IP: "10.239.24.184" ),
        Quote(Name: "TPE4-Rainbow", Description: "TPE4-Rainbow", IP: "10.247.24.201" ),
        Quote(Name: "TPE5-Coffee", Description: "TPE5-Coffee", IP: "10.247.24.202" ),
    ]
}

extension Quote: CustomStringConvertible {
    var description: String {
        return "\(Name) "
    }
}
