class Racer
  attr_accessor :id, :number, :first_name, :last_name, :gender, :group, :secs

  def self.mongo_client
    return Mongoid::Clients.default
  end

  def self.collection
    return mongo_client['racers']
  end

  def self.all(prototype={}, sort={number:1}, skip=0, limit=-1)
    return collection.find(prototype)
      .sort(sort)
      .skip(skip)
      .limit(limit)
  end

  def self.find(id)
    result = collection.find(_id: BSON::ObjectId(id.to_s)).first
    return result.nil? ? nil : Racer.new(result)
  end

  def initialize(params={})
    @id=params[:_id].nil? ? params[:id] : params[:_id].to_s
    @number=params[:number].to_i
    @first_name=params[:first_name]
    @last_name=params[:last_name]
    @gender=params[:gender]
    @group=params[:group]
    @secs=params[:secs].to_i
  end

  def save
    saved = self.class.collection.insert_one(number: @number,
                         first_name: @first_name,
                         last_name: @last_name,
                         gender: @gender,
                         group: @group,
                         secs: @secs)

    @id = saved.inserted_id.to_s
  end

  def update(params)
    @number=params[:number].to_i
    @first_name=params[:first_name]
    @last_name=params[:last_name]
    @gender=params[:gender]
    @group=params[:group]
    @secs=params[:secs].to_i

    self.class.collection
      .find(_id: BSON::ObjectId(@id))
      .update_one(params)
  end

  def destroy
    self.class.collection
      .find(_id: BSON::ObjectId(@id))
      .delete_one
  end

end
