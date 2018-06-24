<p align="center">
  <img width="549" height="175" src="https://tinyimg.io/i/5uu7IFf.png"><br>
</p>

## Inspiration

WelcomeKit aims to be an easy to use iOS Library for creating beautiful user onboarding experiences with Lottie and Adobe After Effects.

Every time I see animated welcome/onboarding screens that match a user's drag or interaction speed, I always go "how in the world do they do that?". Manually animating drawn or geometric shapes/components seemed like a really daunting task, but with AirBnb's <a href="https://github.com/airbnb/lottie-ios" style="text-decoration: none"><b>Lottie</b></a> Animation Library, and Adobe After Effects, we're able to make these same user experiences without the technical overhead by delegating animation efforts to the designer.

<p align="center"><br>
<img src="https://github.com/josh-marasigan/WelcomeKit/blob/master/WelcomeKitExample.gif" width="360" height="667" />
</p>

## Dependencies

WelcomeKit requires `Lottie` and `SnapKit` as dependencies. 

To run, first install Cocoapods by running this in your terminal:

`sudo gem install cocoapods`

Next, place the following snippet to your Podfile's app target.

```
pod 'lottie-ios'
pod 'SnapKit'
```

Finally, `cd` to the current project directory (make sure you are in the same directory as the Podfile) and run:

`pod install`

## How Does It Work?

Internally, each 'page' in `WKPageContentView` is a UIViewController subclass named `WKPageView`.

`WKPageContentView` is abstracted for you, but you'll need to instantiate an array of `WKPageView`s and create an instance of an LOTAnimationView in order to initialize a `WKViewController` (Which is the core view for our animations and page flow)

Your LOTAnimationView and WKPageView pages will all be displayed within WelcomeKit's main class: `WKViewController`

`WKViewController` will have optional parameters with default values available (which is documented within its init header), but requires some non default parameters in order to initialize.

```swift
class WKViewController: UIViewController {
    .
    init(
    pageViews: [WKPageView],
    animationView: LOTAnimationView,
    evenAnimationTimePartition: CGFloat?,
    .
    // Optional Parameters
    .
    )
```
 `pageViews` is an array of WKPageViews (UIViewController subclass) representing the 'Title' and 'Subtitle' Views which the Page Controller transitions. Swiping to the left (if not at the first page) or right (if not at the last page) will execute an animation chunk for our animationView.
 
 `animationView` is our LOTAnimationView instance which is the animation's JSON file exported from Adobe After Effects
 
 `evenAnimationTimePartition` is a CGFloat value indicating the animation intervals the animationView will take when transitioning between pages within the `pageView`. This can be replaced by `customAnimationTimePartitions` which is of type `[CGFloat]`. If `customAnimationTimePartitions` is indicated, it will set the animation intervals to the ones indicated in the array. This give you the ability to animate with uneven animation progress intervals.

Here's an example (which can be found in the sample app) on how a typical UIViewController might implement WelcomeKit:

```swift
import UIKit
import SnapKit
import WelcomeKit
import Lottie

class ViewController: UIViewController {

    // MARK: - Properties
    private var welcomeVC: WKViewController!
    private var pageViews: [WKPageView]!
    private var mainAnimationView: LOTAnimationView!

    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()
    }

    // MARK: - UI
    private func configUI() {
        self.setBackgroundColor()

        // Create LOTAnimationView instance and set configurations
        self.mainAnimationView = LOTAnimationView(name: "servishero_loading")
        self.mainAnimationView.animationSpeed = 0.5
        self.mainAnimationView.contentMode = .scaleAspectFit

        // Instantiate the page views to be displayed
        self.pageViews = configPageViews()

        // Instantiating a WKViewController
        self.welcomeVC = WKViewController(
            pageViews: pageViews,
            animationView: mainAnimationView,
            evenAnimationTimePartition: 0.118
        )

        // Auto Layout
        self.view.addSubview(self.welcomeVC.view)
        self.welcomeVC.view.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().offset(32)
            make.bottom.trailing.equalToSuperview().offset(-32)
        }
    }

    // Set WKPageView(s) and their View Model instances
    private func configPageViews() -> [WKPageView] {
        var pages = [WKPageView]()

        let firstPageViewModel = WKPageViewModel(
        title: "First Title",
        description: "This is the first page in our welcome pages.")
        let firstPage = WKPageView(viewModel: firstPageViewModel)

        let secondPageViewModel = WKPageViewModel(
        title: "Next Title",
        description: "This is the middle page in our welcome pages.")
        let secondPage = WKPageView(viewModel: secondPageViewModel)

        let lastPageViewModel = WKPageViewModel(
        title: "Last Title",
        description: "You've reached the end of our onboarding screens.")
        let lastPage = WKPageView(viewModel: lastPageViewModel)

        // You can also edit WKPageView's UILabel properties for styling
        firstPage.titleLabel?.font = UIFont.boldSystemFont(ofSize: 50.0)
        firstPage.descriptionLabel?.font = UIFont.systemFont(ofSize: 16.0)

        secondPage.titleLabel?.font = UIFont.boldSystemFont(ofSize: 50.0)
        secondPage.descriptionLabel?.font = UIFont.systemFont(ofSize: 16.0)

        lastPage.titleLabel?.font = UIFont.boldSystemFont(ofSize: 50.0)
        lastPage.descriptionLabel?.font = UIFont.systemFont(ofSize: 16.0)

        pages.append(firstPage)
        pages.append(secondPage)
        pages.append(lastPage)
        return pages
    }

    private func setBackgroundColor() {
        // Set gradient properties and clip to bounds
        let primaryColor = UIColor(red:1.00, green:0.60, blue:0.62, alpha:1.0)
        let secondaryColor = UIColor(red:0.98, green:0.82, blue:0.77, alpha:1.0)

        let gradientBackgroundColor = CAGradientLayer()
        gradientBackgroundColor.frame = self.view.bounds
        gradientBackgroundColor.colors = [primaryColor.cgColor, secondaryColor.cgColor]
        gradientBackgroundColor.startPoint = CGPoint(x: 1, y: 1)
        gradientBackgroundColor.endPoint = CGPoint(x: 1, y: 0)
        self.view.layer.addSublayer(gradientBackgroundColor)
    }
}
```
## Thanks For Reading!

- If you want to contribute, feel free to submit a pull request.
- If you woud like to request a feature or report a bug, feel free to create an issue.
