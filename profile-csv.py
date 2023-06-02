


# oil well condition
        profile_df = pd.read_table(r'./outcomes/profile.txt', index_col=False, delim_whitespace=True,header=None)

        rofile_columns = ['cooler_condition','valve_condition','internal_pump_leakage','hydrolic_acucumlator_bar','stable_flag']

        profile_df.columns = profile_columns

        for c in profile_columns:
            df[c]= profile_df[c].values
