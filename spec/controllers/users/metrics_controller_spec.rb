require 'rails_helper'

describe Users::MetricsController, type: :controller do
  context "sign-in" do
    let(:user) { Fabricate(:user) }
    before { sign_in user }

    context "create" do
      it "save a metric" do
        post :create, user_id: user.id, metric: {name: "testmetric", value: 3}, format: :json
        expect(response.code).to eq("201")
        get :show, user_id: user.id, id: json['metric']['id'], format: :json
        expect(json).to eq("metric" => {"id" => json['metric']['id'], "name" => "testmetric", "value" => 3})
      end

      it "should fail if metric is not valid" do
        post :create, user_id: user.id, metric: {name: "testmetric", value: -1}, format: :json
        expect(response.code).to eq("422")

        post :create, user_id: user.id, metric: {name: "", value: 3}, format: :json
        expect(response.code).to eq("422")

        post :create, user_id: user.id, metric: {value: 3}, format: :json
        expect(response.code).to eq("422")

        post :create, user_id: user.id, metric: {name: "testmetric", value: 11}, format: :json
        expect(response.code).to eq("422")

        post :create, user_id: user.id, metric: {name: "testmetric"}, format: :json
        expect(response.code).to eq("422")
      end
    end

    context "index" do
      let(:user) { Fabricate(:user) }

      it "should return [] if metrics are not found" do
        get :index, user_id: user.id, format: :json
        expect(json).to eq("metrics" => [])
      end

      it "should return all metrics" do
        post :create, user_id: user.id, metric: {name: "metric1", value: 3}, format: :json
        expect(response.code).to eq("201")
        id1 = json['metric']['id']

        put :update, user_id: user.id, id: id1, metric: {name: "metric1", value: 6}, format: :json
        expect(response.code).to eq("204")

        post :create, user_id: user.id, metric: {name: "metric2", value: 3}, format: :json
        expect(response.code).to eq("201")
        id2 = json['metric']['id']

        get :index, user_id: user.id, format: :json
        expect(response.code).to eq("200")
        expect(json).to eq("metrics" =>[
                                        {
                                          "id" => id1,
                                          "name" => "metric1",
                                          "value" => 6
                                        },
                                        {
                                          "id" => id2,
                                          "name" => "metric2",
                                          "value" => 3
                                        }
                                       ])
      end
    end

    it "can delete metrics" do
      post :create, user_id: user.id, metric: {name: "metric1", value: 5}, format: :json
      expect(response.code).to eq("201")

      delete :destroy, user_id: user.id, id: json['metric']['id'], format: :json
      expect(response.code).to eq("204")

      post :create, user_id: user.id, metric: {name: "metric2", value: 3}, format: :json
      expect(response.code).to eq("201")

      get :index, user_id: user.id, format: :json
      expect(json).to eq("metrics" => [
                          {
                            "id" => json['metrics'].first['id'],
                            "name" => "metric2",
                            "value" => 3
                          }
                         ])
    end
  end
end

