// Daily Dharma settings. This is the only file you need to edit to turn on accounts.
// Leave supabaseUrl empty and the game runs as before, with stats saved on each device only.
window.DHARMA_CONFIG = {
  supabaseUrl: "https://qyhbuyoewuzsmdcpdniu.supabase.co",
  supabaseAnonKey: "sb_publishable_yCctZeh_3slsnOX_8Zcp8Q_LMnvvu-l",
  googleClientId: "245236471858-gg8skr08fe5kfd31j02f4jadrir0rtjs.apps.googleusercontent.com",

  // Login buttons to show. Email login is always on.
  // Turn Apple on only after you've set up Sign in with Apple in Supabase.
  providers: {
    google: true,
    apple: false
  }
};
