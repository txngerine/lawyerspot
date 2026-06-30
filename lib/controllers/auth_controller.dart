import 'package:get/get.dart';
import '../models/auth_model.dart';
import '../services/auth_service.dart';

class AuthController extends GetxController {
  final sessionUser = Rxn<SessionUser>();
  final isLoggedIn = false.obs;
  final isLawyer = false.obs;
  final isLoading = false.obs;
  final errorMessage = Rxn<String>();

  @override
  void onInit() {
    checkSession();
    super.onInit();
  }

  Future<void> login(String email, String password, {String? role}) async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      final request = LoginRequest(email: email, password: password, role: role);
      await Get.find<AuthService>().login(request);
      await checkSession();
      if (!isLoggedIn.value && errorMessage.value == null) {
        errorMessage.value = 'Failed to verify session. Please try again.';
      }
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> lawyerSignup({
    required String name,
    required String email,
    required String password,
    String? phone,
    required String practice,
    String? barId,
    String? citySlug,
  }) async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      final request = LawyerSignupRequest(
        name: name,
        email: email,
        password: password,
        phone: phone,
        practice: practice,
        barId: barId,
        citySlug: citySlug,
      );
      await Get.find<AuthService>().lawyerSignup(request);
      await checkSession();
      if (!isLoggedIn.value && errorMessage.value == null) {
        errorMessage.value = 'Account created but session verification failed. Please sign in.';
      }
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> clientSignup({
    required String name,
    required String email,
    required String password,
  }) async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      final request = ClientSignupRequest(
        name: name,
        email: email,
        password: password,
      );
      await Get.find<AuthService>().clientSignup(request);
      await checkSession();
      if (!isLoggedIn.value && errorMessage.value == null) {
        errorMessage.value = 'Account created but session verification failed. Please sign in.';
      }
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      await Get.find<AuthService>().logout();
    } catch (_) {}
    sessionUser.value = null;
    isLoggedIn.value = false;
    isLawyer.value = false;
  }

  Future<void> checkSession() async {
    try {
      final user = await Get.find<AuthService>().getMe();
      sessionUser.value = user;
      isLoggedIn.value = true;
      isLawyer.value = user.role == 'lawyer';
    } catch (_) {
      sessionUser.value = null;
      isLoggedIn.value = false;
      isLawyer.value = false;
    }
  }
}
