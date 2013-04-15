class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.string :discipline
      t.string :supervisor
      t.string :research_centre

      t.timestamps
    end
  end
end
