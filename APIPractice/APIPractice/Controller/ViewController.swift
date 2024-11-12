
import UIKit

final class ViewController: UIViewController {
    
    private let upperView = SearchView()
    
    private var weatherManager = WeatherManager()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "Temperature"
        label.font = UIFont.systemFont(ofSize: 50, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    private let cityNameLabel: UILabel = {
        let label = UILabel()
        label.text = "City Name"
        label.font = UIFont.systemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    private let weatherConditionImage: UIImageView = {
        let imView = UIImageView()
        imView.image = UIImage(systemName: "cloud.fill")
        imView.tintColor = .white
        imView.translatesAutoresizingMaskIntoConstraints = false
        return imView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}


private extension ViewController {
    private func setupView() {
        view.backgroundColor = UIColor(patternImage: UIImage(named: "BackImage")!)
        weatherManager.delegate = self
        addSubviews()
        setupConstraints()
        
        upperView.delegate = self
        view.isUserInteractionEnabled = true
        upperView.textField.delegate = self
    }
    
    private func addSubviews() {
        view.addSubview(upperView)
        view.addSubview(weatherConditionImage)
        view.addSubview(temperatureLabel)
        view.addSubview(cityNameLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            upperView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            upperView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            upperView.widthAnchor.constraint(equalToConstant: 300),
            upperView.heightAnchor.constraint(equalToConstant: 100),
            
            weatherConditionImage.topAnchor.constraint(equalTo: upperView.bottomAnchor, constant: 20),
            weatherConditionImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25),
            weatherConditionImage.heightAnchor.constraint(equalToConstant: 100),
            weatherConditionImage.widthAnchor.constraint(equalToConstant: 100),
            
            temperatureLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25),
            temperatureLabel.topAnchor.constraint(equalTo: weatherConditionImage.bottomAnchor, constant: 20),
            
            cityNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25),
            cityNameLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 20)
        ])
    }
}


extension ViewController: WeatherManagerDelegate {
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func didUpdateWeather(_ weatherManager: WeatherManager, _ weather: WeatherModel) {
        print(weather.temperatureString)
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.cityNameLabel.text = weather.cityName
            self.weatherConditionImage.image = UIImage(systemName: weather.conditionName)
        }
    }
}


extension ViewController: SearchViewDelegate {
    func searchButtonPressed() {
        upperView.textField.endEditing(true)
    }
}


extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        upperView.textField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if upperView.textField.text != "" {
            return true
        } else {
            upperView.textField.placeholder = "Type smth"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = upperView.textField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        upperView.textField.text = ""
    }
}
