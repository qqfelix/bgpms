class CreateMeetings < ActiveRecord::Migration
  def change
      create_table :meetings do |t|
        t.string :name
        t.boolean :mon_am
        t.string :mon_amdesc
        t.boolean :mon_pm
        t.string :mon_pmdesc
        t.boolean :tues_am
        t.string :tues_amdesc
        t.boolean :tues_pm
        t.string :tues_pmdesc
        t.boolean :wed_am
        t.string :wed_amdesc
        t.boolean :wed_pm
        t.string :wed_pmdesc
        t.boolean :thur_am
        t.string :thur_amdesc
        t.boolean :thur_pm
        t.string :thur_pmdesc
        t.boolean :fri_am
        t.string :fri_amdesc
        t.boolean :fri_pm
        t.string :fri_pmdesc

        t.timestamps
      end
  end
end
