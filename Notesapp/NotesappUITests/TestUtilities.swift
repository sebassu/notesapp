import Foundation

internal class TestUtilities {

    internal static func navigateToMainView() {
        let application = UIApplication.shared.delegate as! AppDelegate
        let navigationController = application.window.rootViewController as! UINavigationController
        navigationController.popToRootViewController(animated: true)
    }
}
