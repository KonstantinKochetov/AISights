import Foundation

class Parser {

    func readJSON() -> [Denkmal] {
        do {
            if let file = Bundle.main.url(forResource: "short_denkmaeler2", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? [[String: AnyObject]] {
                    // json is an array
                    let data = self.convertDataToDenkmal(object)
                    return data
                } else {
                    debugPrint("JSON is invalid")
                }
            } else {
                debugPrint("no file")
            }
        } catch {
            debugPrint(error.localizedDescription)
        }
        return []
    }

    func convertDataToDenkmal(_ data: [[String: AnyObject]]) -> [Denkmal] {
        var denkmale: [Denkmal] = []
        for element in data {
            denkmale.append(Denkmal(id: element[DenkmalConstants.id] as? String ?? "",
                                    markiert: false,
                                    title: element[DenkmalConstants.title] as? String ?? "",
                                    ort: element[DenkmalConstants.ort] as? String ?? "",
                                    latitude: element[DenkmalConstants.latitude] as? String ?? "",
                                    longitude: element[DenkmalConstants.longitude] as? String ?? "",
                                    entwurfUndAusfuehrung: element[DenkmalConstants.entwurfUndAusfuehrung] as? [String] ?? [],
                                    ausfuehrung: element[DenkmalConstants.ausfuehrung] as? [String] ?? [],
                                    baubeginn: element[DenkmalConstants.baubeginn] as? String ?? "",
                                    fertigstellung: element[DenkmalConstants.fertigstellung] as? String ?? "",
                                    ausfuehrungUndBauherrUndEntwurf: element[DenkmalConstants.ausfuehrungUndBauherrUndEntwurf] as? String ?? "",
                                    entwurfUndFertigstellung: element[DenkmalConstants.entwurfUndFertigstellung] as? String ?? "",
                                    literatur: element[DenkmalConstants.literatur] as? String ?? "",
                                    ausfuehrungUndBauherr: element[DenkmalConstants.ausfuehrungUndBauherr] as? String ?? "",
                                    planungsbeginn: element[DenkmalConstants.planungsbeginn] as? String ?? "",
                                    entwurfUndDatierung: element[DenkmalConstants.entwurfUndDatierung] as? String ?? "",
                                    planungUndAusfuehrung: element[DenkmalConstants.planungUndAusfuehrung] as? String ?? "",
                                    entwurfUndBaubeginnUndFertigstellung: element[DenkmalConstants.entwurfUndBaubeginnUndFertigstellung] as? String ?? "",
                                    entwurf: element[DenkmalConstants.entwurf] as? [String] ?? [],
                                    bauherr: element[DenkmalConstants.bauherr] as? [String] ?? [],
                                    text: element[DenkmalConstants.text] as? String ?? "",
                                    wiederaufbau: element[DenkmalConstants.wiederaufbau] as? String ?? "",
                                    umbau: element[DenkmalConstants.umbau] as? String ?? "",
                                    entwurfUndBaubeginn: element[DenkmalConstants.entwurfUndBaubeginn] as? String ?? "",
                                    image: element[DenkmalConstants.image] as? String ?? "",
                                    strasse: element[DenkmalConstants.strasse] as? [String] ?? [],
                                    planung: element[DenkmalConstants.planung] as? String ?? "",
                                    entwurfUndBauherr: element[DenkmalConstants.entwurfUndBauherr] as? String ?? "",
                                    eigentuemer: element[DenkmalConstants.eigentuemer] as? String ?? "",
                                    datierung: element[DenkmalConstants.datierung] as? [String] ?? []))
        }
        return denkmale
    }
}
