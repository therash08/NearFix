import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_model.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

class AuthService {
  static const _kAccountsKey = 'nearfix_accounts';
  static const _kCurrentUserKey = 'nearfix_current_user';

  UserModel? currentUser;

  AuthService() {
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final s = prefs.getString(_kCurrentUserKey);
    if (s != null && s.isNotEmpty) {
      try {
        currentUser = UserModel.decode(s);
      } catch (_) {}
    }
  }

  Future<List<Map<String, dynamic>>> _readAccounts() async {
    final prefs = await SharedPreferences.getInstance();
    final accountsStr = prefs.getString(_kAccountsKey) ?? '[]';
    try {
      final decoded = jsonDecode(accountsStr);
      if (decoded is List) {
        final List<Map<String, dynamic>> out = [];
        for (final item in decoded) {
          if (item is Map) {
            out.add(Map<String, dynamic>.from(item));
          } else if (item is String) {
            try {
              final parsed = jsonDecode(item);
              if (parsed is Map) out.add(Map<String, dynamic>.from(parsed));
            } catch (_) {}
          }
        }
        return out;
      }
    } catch (_) {}
    return <Map<String, dynamic>>[];
  }

  Future<void> _saveAccounts(List<Map<String, dynamic>> accounts) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kAccountsKey, jsonEncode(accounts));
  }

  Future<void> signUp(UserModel user) async {
    final accounts = await _readAccounts();
    final exists = accounts.any((a) => (a['email'] ?? '') == user.email);
    if (exists) throw Exception('Account with this email already exists');

    accounts.add(user.toJson());
    await _saveAccounts(accounts);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kCurrentUserKey, user.encode());
    currentUser = user;
  }

  Future<void> signIn(String email, String password) async {
    final accounts = await _readAccounts();
    final match = accounts.firstWhere(
      (m) => (m['email'] ?? '') == email && (m['password'] ?? '') == password,
      orElse: () => <String, dynamic>{},
    );

    if (match.isEmpty) throw Exception('Invalid credentials');

    final user = UserModel.fromJson(match);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kCurrentUserKey, jsonEncode(match));
    currentUser = user;
  }

  Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kCurrentUserKey);
    currentUser = null;
  }

  Future<void> updateUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    final accountsStr = prefs.getString(_kAccountsKey) ?? '[]';
    final List accounts = jsonDecode(accountsStr);

    final idx = accounts.indexWhere((a) => (a['id'] ?? '') == user.id);
    if (idx >= 0) {
      accounts[idx] = user.toJson();
      await prefs.setString(_kAccountsKey, jsonEncode(accounts));
      await prefs.setString(_kCurrentUserKey, user.encode());
      currentUser = user;
    } else {
      throw Exception('User not found');
    }
  }
}
