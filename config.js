// Daily Dharma settings. This is the only file you need to edit to turn on accounts.
// Leave supabaseUrl empty and the game runs as before, with stats saved on each device only.
//
// Where to find these values: Supabase dashboard > Project Settings > API
//   supabaseUrl      = "Project URL"
//   supabaseAnonKey  = the "anon" "public" key (safe to publish; your database rules protect the data)
window.DHARMA_CONFIG = {
  supabaseUrl: "https://qyhbuyoewuzsmdcpdniu.supabase.co",
  supabaseAnonKey: "sb_publishable_yCctZeh_3slsnOX_8Zcp8Q_LMnvvu-l",

  // Login buttons to show. Email login is always on.
  // Turn Apple on only after you've set up Sign in with Apple in Supabase.
  providers: {
    google: true,
    apple: false
  }
};
