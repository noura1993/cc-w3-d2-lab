require('pg')

class Property

    attr_reader :id
    attr_accessor :address, :value, :number_of_bedrooms, :year_built

    def initialize(property)
        @id = property['id'].to_i if property['id']
        @address = property['address']
        @value = property['value'].to_i
        @number_of_bedrooms = property['number_of_bedrooms'].to_i
        @year_built = property['year_built'].to_i
    end

    def save()
        db = PG.connect({ dbname: 'scotland_houses', host: 'localhost'})
        sql = "INSERT INTO properties 
        (address, value, number_of_bedrooms, year_built) 
        VALUES
        ($1, $2, $3, $4)
        RETURNING *;"
        values = [@address, @value, @number_of_bedrooms, @year_built]
        db.prepare('save', sql)
        @id = db.exec_prepared('save', values)[0]['id'].to_i
        db.close()
    end

    def update()
        db = PG.connect({ dbname: 'scotland_houses', host: 'localhost'})
        sql = "UPDATE properties 
        SET 
        (address, value, number_of_bedrooms, year_built) 
        = 
        ($1, $2, $3, $4) WHERE id = $5"
        values = [@address, @value, @number_of_bedrooms, @year_built, @id]
        db.prepare('update', sql)
        db.exec_prepared('update', values)
        db.close()
    end


    def delete()
        db = PG.connect({ dbname: 'scotland_houses', host: 'localhost'})
        sql = "DELETE FROM properties WHERE id = $1;"
        values = [@id]
        db.prepare('delete', sql)
        db.exec_prepared('delete', values)
        db.close()
    end

    def Property.all()
        db = PG.connect({ dbname: 'scotland_houses', host: 'localhost'})
        sql = "SELECT * FROM properties;"
        db.prepare('all', sql)
        properties = db.exec_prepared('all')
        db.close()
        return properties.map{ |property| Property.new(property)}
    end

    def Property.find(id)
        db = PG.connect({ dbname: 'scotland_houses', host: 'localhost'})
        sql = "SELECT * FROM properties WHERE id = $1;"
        values = [id]
        db.prepare('find', sql)
        result = db.exec_prepared('find', values)[0]
        db.close()
        return nil if result == nil
        return Property.new(result)
    end

    def Property.find_by_address(address)
        db = PG.connect({ dbname: 'scotland_houses', host: 'localhost'})
        sql = "SELECT * FROM properties WHERE address = $1;"
        values = [address]
        db.prepare('find_by_address', sql)
        result = db.exec_prepared('find_by_address', values)[0]
        db.close()
        return nil if result == nil
        return Property.new(result)
    end

end