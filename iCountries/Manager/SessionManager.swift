import Foundation


class SessionManager {
    static var shared: SessionManager = {
        let instance = SessionManager()
        return instance
    }()
    
    private init() {}
    
    func countriesRequest(dataResponse: @escaping ([WelcomeElement]) -> Void) {
        let urlString = "https://restcountries.com/v3.1/all"
        let baseURL = URL(string: urlString)
        let sessionConfiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfiguration)
        let dataTask = session.dataTask(with: baseURL!) { (data, response, error) in
            guard error == nil else { return }
            guard let data = data else { return }
            if let responseData = self.parseJSON(data: data) {
                DispatchQueue.main.async {
                    dataResponse(responseData)
                }
            }
        }
        dataTask.resume()
    }
    
    func countryRequest(common: String, dataResponse: @escaping ([WelcomeElement]) -> Void) {
        
      let urlString = "https://restcountries.com/v3.1/name/"
        var baseURL = URL(string: urlString)
        baseURL!.appendPathComponent("\(common)")
        let sessionConfiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfiguration)
        let dataTask = session.dataTask(with: baseURL!) { (data, response, error) in
            guard error == nil else { return }
            guard let data = data else { return }
            if let responseData = self.parseJSON(data: data) {
                DispatchQueue.main.async {
                    dataResponse(responseData)
                }
            }
        }
        dataTask.resume()
    }
    
    func parseJSON(data: Data) -> [WelcomeElement]? {
        do {
            let main = try JSONDecoder().decode([WelcomeElement].self, from: data)
            return main
        } catch {
            return nil
        }
    }
}
