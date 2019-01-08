class CreatePontoDeVendas < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'uuid-ossp'

    create_table :ponto_de_vendas, id: :uuid do |t|
      t.string :trading_name
      t.string :owner_name
      t.string :document
      t.string :coverage_area
      t.string :address

      t.timestamps
    end
  end
end
