enum AnalyticsEventName {
  loginPageViewed,
  registerPageViewed,
  homePageViewed,
  createTodoPageViewed,

  userCreatedWithSuccess,
  userCreatedWithError,

  userLoggedInWithSuccess,
  userLoggedInWithError,

  userLoggedOutWithSuccess,
  userLoggedOutWithError,

  fetchTodosWithSuccess,
  fetchTodosWithError,

  todoCreatedWithSuccess,
  todoCreatedWithError,

  todoDeletedWithSuccess,
  todoDeletedWithError,
}

extension AnalyticsEventNameExtension on AnalyticsEventName {
  String get text {
    switch (this) {
      case AnalyticsEventName.loginPageViewed:
        return 'login_page_viewed';
      case AnalyticsEventName.registerPageViewed:
        return 'register_page_viewed';
      case AnalyticsEventName.homePageViewed:
        return 'home_page_viewed';
      case AnalyticsEventName.createTodoPageViewed:
        return 'create_todo_page_viewed';
      case AnalyticsEventName.userCreatedWithSuccess:
        return 'user_created_with_success';
      case AnalyticsEventName.userCreatedWithError:
        return 'user_created_with_error';
      case AnalyticsEventName.userLoggedInWithSuccess:
        return 'user_logged_in_with_success';
      case AnalyticsEventName.userLoggedInWithError:
        return 'user_logged_in_with_error';
      case AnalyticsEventName.userLoggedOutWithSuccess:
        return 'user_logged_out_with_success';
      case AnalyticsEventName.userLoggedOutWithError:
        return 'user_logged_out_with_error';
      case AnalyticsEventName.fetchTodosWithSuccess:
        return 'fetch_todos_with_success';
      case AnalyticsEventName.fetchTodosWithError:
        return 'fetch_todos_with_error';
      case AnalyticsEventName.todoCreatedWithSuccess:
        return 'todo_created_with_success';
      case AnalyticsEventName.todoCreatedWithError:
        return 'todo_created_with_error';
      case AnalyticsEventName.todoDeletedWithSuccess:
        return 'todo_deleted_with_success';
      case AnalyticsEventName.todoDeletedWithError:
        return 'todo_deleted_with_error';
    }
  }
}
