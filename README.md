<p align="center">
  <img width="540" height="175" src="http://tinyimg.io/i/5uu7IFf.png"><br>
</p>

## Inspiration

WelcomeKit aims to be an easy to use iOS Library for creating beautiful user onboarding experiences with Lottie and Adobe After Effects.

Every time I see animated welcome/onboarding screens that match a user's drag or interaction speed, I always go "how in the world do they do that?". Manually animating drawn or geometric shapes/components seemed like a really daunting task, but with AirBnb's <a href="https://github.com/airbnb/lottie-ios" style="text-decoration: none"><b>Lottie</b></a> Animation Library, and Adobe After Effects, we're able to make these same user experiences without the technical overhead by delegating animation efforts to the designer.

<p align="center"><br>
<img src="https://github.com/josh-marasigan/WelcomeKit/blob/master/WelcomeKitExample.gif" width="375" height="667" />
</p>

## Dependencies:

WelcomeKit requires `Lottie` and `SnapKit` as dependencies. 

To run, first install Cocoapods by running this in your terminal:

`sudo gem install cocoapods`

Next, place the following snippet to your Podfile's app target.

```
pod 'lottie-ios'
pod 'SnapKit'
```

Finally, `cd` to the current project directory (make sure you are in the same directory as the Podfile) :

Run:
 `pod install`

## How Does It Work?:

Internally, each 'page' in `WKPageContentView` is a UIViewController subclass named `WKPageView`.

`WKPageContentView` is abstracted for you, but you'll need to instantiate an array of `WKPageView`s and create an instance of an LOTAnimationView in order to initialize a `WKViewController` (Which is the core view for our animations and page flow)

Your LOTAnimationView and WKPageView pages will all be displayed within WelcomeKit's main class: `WKViewController`

`WKViewController` will have optional parameters with default values available (which is documented within its init header), but requires `5` non default parameters in order to initialize.

```swift
class WKViewController: UIViewController {
    .
    .
    .
    init(primaryColor: UIColor,
             secondaryColor: UIColor?,
             pageViews: [WKPageView],
             animationView: LOTAnimationView,
             evenAnimationTimePartition: CGFloat?,
             .
             .
             .
```

`primaryColor` and `secondaryColor` are for WKViewController's background color gradient. If `secondaryColor` is set to nil, the background will default to a solid `primaryColor` instead of a gradient.

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
        // WKViewController Parameter Instances
        let primaryColor = UIColor(red:1.00, green:0.60, blue:0.62, alpha:1.0)
        let secondaryColor = UIColor(red:0.98, green:0.82, blue:0.77, alpha:1.0)
        
        // Create LOTAnimationView instance and set configurations
        self.mainAnimationView = LOTAnimationView(name: "servishero_loading")
        self.mainAnimationView.animationSpeed = 0.5
        
        // Instantiate the page views to be displayed
        self.pageViews = configPageViews()
        
        // Instantiating a WKViewController
        self.welcomeVC = WKViewController(
            primaryColor: primaryColor,
            secondaryColor: secondaryColor,
            pageViews: pageViews,
            animationView: mainAnimationView,
            evenAnimationTimePartition: 0.118,
            
            // Optional Parameters
            sideContentPadding: 32,
            verticalContentPadding: 32
        )
        
        // Auto Layout
        self.view.addSubview(self.welcomeVC.view)
        self.welcomeVC.view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    // Set WKPageView(s) and their View Model instances
    private func configPageViews() -> [WKPageView] {
        var pages = [WKPageView]()
        
        // First Page
        let firstPageDescription =
        """
        This is the first page in our welcome pages. The animation should have started to perform its animation.

        If an animation progression was indicated, this animation should not have gone past the designated animation progression value (these are from 0 to 1).
        """
        let firstPageViewModel = WKPageViewModel(title: "First Title", description: firstPageDescription)
        let firstPage = WKPageView(viewModel: firstPageViewModel)
        
        // Second Page
        let secondPageDescription =
        """
        This is the middle page in our welcome pages.

        Swipe left or right and to see our animation play in their designated start times.
        """
        let secondPageViewModel = WKPageViewModel(title: "Next Title",description: secondPageDescription)
        let secondPage = WKPageView(viewModel: secondPageViewModel)
        
        // Last Page
        let lastPageDescription =
        """
        You've reached the end of our onboarding screens, feel free to add more.

        As you can see, we can arbitrarily append pages. Just be sure to configure animation speed accordingly.
        """
        let lastPageViewModel = WKPageViewModel(title: "Last Title", description: lastPageDescription)
        let lastPage = WKPageView(viewModel: lastPageViewModel)
        
        // If desired, you can also edit WKPageView's UILabel properties for styling
        firstPage.titleLabel?.font = UIFont.boldSystemFont(ofSize: 50.0)
        firstPage.descriptionLabel?.font = UIFont.systemFont(ofSize: 16.0)
        
        secondPage.titleLabel?.font = UIFont.boldSystemFont(ofSize: 50.0)
        secondPage.descriptionLabel?.font = UIFont.systemFont(ofSize: 16.0)

        lastPage.titleLabel?.font = UIFont.boldSystemFont(ofSize: 50.0)
        lastPage.descriptionLabel?.font = UIFont.systemFont(ofSize: 16.0)
        
        // Set pages to view controller list, track via 'pages' array
        pages.append(firstPage)
        pages.append(secondPage)
        pages.append(lastPage)
        return pages
    }
}
```
## Thanks For Reading!

- If you would like to contribute, feel free to submit a pull request.
- If you would like to request a feature or report a bug, feel free to create an issue.
