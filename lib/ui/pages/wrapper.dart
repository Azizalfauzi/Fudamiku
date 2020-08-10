part of 'pages.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageBloc, PageState>(
      builder: (_, pageState) =>
      
      (pageState is OnSplashPage)
      ? SplashPage()

      : (pageState is OnSignInPage)
      ? SignInPage()

      : (pageState is OnSignUpPage)
      ? SignUpPage(pageState.auth)

      : (pageState is OnAddressPage)
      ? AddressPage(pageState.auth)

      : (pageState is OnMainPage)
      ? MainPage()

      : (pageState is OnFoodDetailPage)
      ? FoodDetailPage(pageState.food)

      : (pageState is OnCheckoutPage)
      ? CheckoutPage(pageState.food)

      : (pageState is OnSuccessPage)
      ? SuccessPage(pageState.title, pageState.subtitle, pageState.illustrationImage, pageState.isOrder)

      : Container()
    );
  }
}