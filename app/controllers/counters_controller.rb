class CountersController < ApplicationController
  layout 'railway'

  before_action :set_counter, only: [:show, :edit, :update, :destroy]

  # GET /counters
  # GET /counters.json
  def index
    @counters = Counter.all
  end

  def railway
    @cities = cities
    @google_streetview_key = Rails.application.credentials.dig(:google,:streetview_key)
    @scores = ActiveModel::Serializer::CollectionSerializer.new(Counter.all&.order(value: :desc).limit(10), each_serializer: CounterSerializer)
  end

  # GET /counters/1
  # GET /counters/1.json
  def show
  end

  # GET /counters/new
  def new
    @counter = Counter.new
  end

  # GET /counters/1/edit
  def edit
  end

  # POST /counters
  # POST /counters.json
  def create
    @counter = Counter.new(counter_params)

    respond_to do |format|
      if @counter.save
        format.html { redirect_to @counter, notice: 'Counter was successfully created.' }
        format.json { render :show, status: :created, location: @counter }
      else
        format.html { render :new }
        format.json { render json: @counter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /counters/1
  # PATCH/PUT /counters/1.json
  def update
    respond_to do |format|
      if @counter.update(counter_params)
        format.html { redirect_to @counter, notice: 'Counter was successfully updated.' }
        format.json { render :show, status: :ok, location: @counter }
      else
        format.html { render :edit }
        format.json { render json: @counter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /counters/1
  # DELETE /counters/1.json
  def destroy
    @counter.destroy
    respond_to do |format|
      format.html { redirect_to counters_url, notice: 'Counter was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_counter
      @counter = Counter.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def counter_params
      params.require(:counter).permit(:name, :value)
    end

    def cities
      @cities = [
      {
          "name": "Moscow, Russia",
          "lat": 55.75,
          "lng": 37.6166667
      },
      {
          "name": "London, UK",
          "lat": 51.5081289,
          "lng": -0.128005
      },
      {
          "name": "St Petersburg, Russia",
          "lat": 60.07623830000001,
          "lng": 30.1213829
      },
      {
          "name": "Berlin, Germany",
          "lat": 52.524268,
          "lng": 13.40629
      },
      {
          "name": "Madrid, Spain",
          "lat": 40.4166909,
          "lng": -3.700345399999999
      },
      {
          "name": "Rome, Italy",
          "lat": 41.8905198,
          "lng": 12.4942486
      },
      {
          "name": "Kiev, Kyiv city, Ukraine, 02000",
          "lat": 50.4501,
          "lng": 30.5234
      },
      {
          "name": "Paris, France",
          "lat": 48.856614,
          "lng": 2.3522219
      },
      {
          "name": "Bucharest, Romania",
          "lat": 44.43771100000001,
          "lng": 26.0973669
      },
      {
          "name": "Budapest, Hungary",
          "lat": 47.4984056,
          "lng": 19.0407578
      },
      {
          "name": "Hamburg, Germany",
          "lat": 53.556866,
          "lng": 9.994622
      },
      {
          "name": "Minsk, Belarus",
          "lat": 53.9,
          "lng": 27.5666667
      },
      {
          "name": "Warsaw, Poland",
          "lat": 52.2296756,
          "lng": 21.0122287
      },
      {
          "name": "Belgrade, Serbia",
          "lat": 44.802416,
          "lng": 20.465601
      },
      {
          "name": "Vienna, Austria",
          "lat": 48.2081743,
          "lng": 16.3738189
      },
      {
          "name": "Kharkiv, Kharkivs'ka oblast, Ukraine, 61000",
          "lat": 49.9935,
          "lng": 36.230383
      },
      {
          "name": "Barcelona, Spain",
          "lat": 41.387917,
          "lng": 2.1699187
      },
      {
          "name": "Novosibirsk, Novosibirskaya oblast, Russia",
          "lat": 55.0333333,
          "lng": 82.9166667
      },
      {
          "name": "Nizhny Novgorod, Nizhegorodskaya oblast, Russia",
          "lat": 56.3166667,
          "lng": 44
      },
      {
          "name": "Milan, Italy",
          "lat": 45.463681,
          "lng": 9.1881714
      },
      {
          "name": "Yekaterinburg, Sverdlovskaya oblast, Russia",
          "lat": 56.84999999999999,
          "lng": 60.59999999999999
      },
      {
          "name": "Munich, Germany",
          "lat": 48.1448353,
          "lng": 11.5580067
      },
      {
          "name": "Prague, Czech Republic",
          "lat": 50.0878114,
          "lng": 14.4204598
      },
      {
          "name": "Samara, Samarskaya oblast, Russia",
          "lat": 53.2415041,
          "lng": 50.2212463
      },
      {
          "name": "Omsk, Omsk Oblast, Russia",
          "lat": 54.9833333,
          "lng": 73.3666667
      },
      {
          "name": "Sofia, Bulgaria",
          "lat": 42.6964917,
          "lng": 23.3260106
      },
      {
          "name": "Dnipro, Dnipropetrovs'ka oblast, Ukraine, 49000",
          "lat": 48.464717,
          "lng": 35.046183
      },
      {
          "name": "Kazan, Republic of Tatarstan, Russia",
          "lat": 55.8005556,
          "lng": 49.1055556
      },
      {
          "name": "Ufa, Republic of Bashkortostan, Russia",
          "lat": 54.7833333,
          "lng": 56.0333333
      },
      {
          "name": "Chelyabinsk, Chelyabinskaya oblast, Russia",
          "lat": 55.201612,
          "lng": 61.43839000000001
      },
      {
          "name": "Donetsk, Donets'ka oblast, Ukraine, 83000",
          "lat": 48.015883,
          "lng": 37.80285
      },
      {
          "name": "Naples, Italy",
          "lat": 40.8399833,
          "lng": 14.2525421
      },
      {
          "name": "Birmingham, West Midlands, UK",
          "lat": 52.48624299999999,
          "lng": -1.890401
      },
      {
          "name": "Perm, Perm Krai, Russia",
          "lat": 58.00000000000001,
          "lng": 56.25
      },
      {
          "name": "Rostov, Rostovskaya oblast, Russia",
          "lat": 47.2166667,
          "lng": 39.7
      },
      {
          "name": "Odessa, Odes'ka oblast, Ukraine, 65000",
          "lat": 46.484583,
          "lng": 30.7326
      },
      {
          "name": "Volgograd, Volgogradskaya oblast, Russia",
          "lat": 48.7,
          "lng": 44.51666669999999
      },
      {
          "name": "Cologne, Germany",
          "lat": 50.9580867,
          "lng": 6.9204493
      },
      {
          "name": "Turin, Italy",
          "lat": 45.0708515,
          "lng": 7.6843404
      },
      {
          "name": "Voronezh, Voronezh Oblast, Russia",
          "lat": 51.65,
          "lng": 39.2
      },
      {
          "name": "Krasnoyarsk, Krasnoyarsk Krai, Russia",
          "lat": 56,
          "lng": 93
      },
      {
          "name": "Saratov, Saratov Oblast, Russia",
          "lat": 51.5330556,
          "lng": 46.0344444
      },
      {
          "name": "Zagreb, Croatia",
          "lat": 45.814912,
          "lng": 15.9785145
      },
      {
          "name": "Zaporozhia, Zaporiz'ka oblast, Ukraine, 69061",
          "lat": 47.8388,
          "lng": 35.139567
      },
      {
          "name": "Lodz, Poland",
          "lat": 51.7592485,
          "lng": 19.4559833
      },
      {
          "name": "Marseille, France",
          "lat": 43.296482,
          "lng": 5.36978
      },
      {
          "name": "Riga, Latvia",
          "lat": 56.9462031,
          "lng": 24.1042872
      },
      {
          "name": "Lviv, L'vivs'ka oblast, Ukraine, 79000",
          "lat": 49.839683,
          "lng": 24.029717
      },
      {
          "name": "Athens, Greece",
          "lat": 37.9753357,
          "lng": 23.7361497
      },
      {
          "name": "Thessaloniki, Greece",
          "lat": 40.63935,
          "lng": 22.944607
      },
      {
          "name": "Stockholm, Sweden",
          "lat": 59.32893000000001,
          "lng": 18.06491
      },
      {
          "name": "Krakow, Poland",
          "lat": 50.06465009999999,
          "lng": 19.9449799
      },
      {
          "name": "Valencia, Spain",
          "lat": 39.4702393,
          "lng": -0.3768049
      },
      {
          "name": "Amsterdam, The Netherlands",
          "lat": 52.3702157,
          "lng": 4.895167900000001
      },
      {
          "name": "Leeds, West Yorkshire, UK",
          "lat": 53.801279,
          "lng": -1.548567
      },
      {
          "name": "Tolyatti, Samarskaya oblast, Russia",
          "lat": 53.4833333,
          "lng": 49.51666669999999
      },
      {
          "name": "Kryvyi Rih, Dnipropetrovs'ka oblast, Ukraine, 50000",
          "lat": 47.910483,
          "lng": 33.391783
      },
      {
          "name": "Seville, Spain",
          "lat": 37.38263999999999,
          "lng": -5.996295099999999
      },
      {
          "name": "Palermo, Italy",
          "lat": 38.11564,
          "lng": 13.3614059
      },
      {
          "name": "Ulyanovsk, Ulyanovskaya oblast, Russia",
          "lat": 54.3166667,
          "lng": 48.3666667
      },
      {
          "name": "Chisinau, Moldova",
          "lat": 47.02685899999999,
          "lng": 28.841551
      },
      {
          "name": "Genoa, Italy",
          "lat": 44.4070624,
          "lng": 8.9339889
      },
      {
          "name": "Izhevsk, Udmurt Republic, Russia",
          "lat": 56.84999999999999,
          "lng": 53.2166667
      },
      {
          "name": "Frankfurt, Germany",
          "lat": 50.1109221,
          "lng": 8.6821267
      },
      {
          "name": "Krasnodar, Krasnodarskiy Kray, Russia",
          "lat": 45.0333333,
          "lng": 38.9833333
      },
      {
          "name": "Wroclaw, Poland",
          "lat": 51.1078852,
          "lng": 17.0385376
      },
      {
          "name": "Glasgow, UK",
          "lat": 55.864237,
          "lng": -4.251806
      },
      {
          "name": "Yaroslavl, Yaroslavskaya oblast, Russia",
          "lat": 57.6527778,
          "lng": 39.8761111
      },
      {
          "name": "Khabarovsk, Khabarovsk Krai, Russia",
          "lat": 48.4666667,
          "lng": 135.1
      },
      {
          "name": "Vladivostok, Primorsky Krai, Russia",
          "lat": 43.1666667,
          "lng": 131.9333333
      },
      {
          "name": "Zaragoza, Spain",
          "lat": 41.6562873,
          "lng": -0.8765379000000001
      },
      {
          "name": "Essen, Germany",
          "lat": 51.46227,
          "lng": 7.008653300000001
      },
      {
          "name": "Rotterdam, The Netherlands",
          "lat": 51.92421599999999,
          "lng": 4.481776
      },
      {
          "name": "Irkutsk, Irkutsk Oblast, Russia",
          "lat": 52.2833333,
          "lng": 104.2666667
      },
      {
          "name": "Dortmund, Germany",
          "lat": 51.50409879999999,
          "lng": 7.4835995
      },
      {
          "name": "Stuttgart, Germany",
          "lat": 48.7754181,
          "lng": 9.181758799999999
      },
      {
          "name": "Barnaul, Altai Krai, Russia",
          "lat": 53.3333333,
          "lng": 83.7666667
      },
      {
          "name": "Vilnius, Lithuania",
          "lat": 54.6893865,
          "lng": 25.2800243
      },
      {
          "name": "Poznan, Poland",
          "lat": 52.406374,
          "lng": 16.9251681
      },
      {
          "name": "Dusseldorf, Germany",
          "lat": 51.220532,
          "lng": 6.810061699999999
      },
      {
          "name": "Novokuznetsk, Kemerovo Oblast, Russia",
          "lat": 53.75,
          "lng": 87.1166667
      },
      {
          "name": "Lisbon, Portugal",
          "lat": 38.70693199999999,
          "lng": -9.135632099999999
      },
      {
          "name": "Helsinki, Finland",
          "lat": 60.169845,
          "lng": 24.9385508
      },
      {
          "name": "Malaga, Spain",
          "lat": 36.7196484,
          "lng": -4.420016299999999
      },
      {
          "name": "Bremen, Germany",
          "lat": 53.0847558,
          "lng": 8.8208279
      },
      {
          "name": "Sheffield, South Yorkshire, UK",
          "lat": 53.38112899999999,
          "lng": -1.470085
      },
      {
          "name": "Sarajevo, Bosnia and Herzegovina",
          "lat": 43.8476,
          "lng": 18.3564
      },
      {
          "name": "Penza, Penza Oblast, Russia",
          "lat": 53.2,
          "lng": 45.01666669999999
      },
      {
          "name": "Ryazan, Ryazanskaya oblast, Russia",
          "lat": 54.6166667,
          "lng": 39.7333333
      },
      {
          "name": "Orenburg, Orenburgskaya oblast, Russia",
          "lat": 51.7833333,
          "lng": 55.09999999999999
      },
      {
          "name": "Naberezhnye Chelnye, Republic of Tatarstan, Russia",
          "lat": 55.7,
          "lng": 52.3166667
      },
      {
          "name": "Duisburg, Germany",
          "lat": 51.4344079,
          "lng": 6.762329299999999
      },
      {
          "name": "Lipetsk, Lipetskaya oblast, Russia",
          "lat": 52.59999999999999,
          "lng": 39.5666667
      },
      {
          "name": "Hanover, Germany",
          "lat": 52.3843792,
          "lng": 9.7271906
      },
      {
          "name": "Mykolaiv, Mykolaivs'ka oblast, Ukraine, 54000",
          "lat": 46.975033,
          "lng": 31.994583
      },
      {
          "name": "Tula, Tul'skaya oblast, Russia",
          "lat": 54.2,
          "lng": 37.6166667
      },
      {
          "name": "Oslo, Norway",
          "lat": 59.9138688,
          "lng": 10.7522454
      },
      {
          "name": "Tyumen, Tyumenskaya oblast, Russia",
          "lat": 57.1666667,
          "lng": 65.55
      },
      {
          "name": "Copenhagen, Denmark",
          "lat": 55.6760968,
          "lng": 12.5683371
      },
      {
          "name": "Kemerovo, Kemerovo Oblast, Russia",
          "lat": 55.34999999999999,
          "lng": 86.05
      },
      {
          "name": "Mariupol', Donets'ka oblast, Ukraine, 87500",
          "lat": 47.097133,
          "lng": 37.543367
      },
      {
          "name": "Leipzig, Germany",
          "lat": 51.3490384,
          "lng": 12.3938226
      },
      {
          "name": "Nuremberg, Germany",
          "lat": 49.4451843,
          "lng": 11.087422
      },
      {
          "name": "Bradford, West Yorkshire, UK",
          "lat": 53.795984,
          "lng": -1.759398
      },
      {
          "name": "Astrakhan, Astrakhanskaya oblast, Russia",
          "lat": 46.35,
          "lng": 48.05
      },
      {
          "name": "Dublin, Co. Dublin, Ireland",
          "lat": 53.34410399999999,
          "lng": -6.267493699999999
      },
      {
          "name": "Tomsk, Tomskaya oblast, Russia",
          "lat": 56.5,
          "lng": 84.96666669999999
      },
      {
          "name": "Dresden, Germany",
          "lat": 51.0305106,
          "lng": 13.7572182
      },
      {
          "name": "Gomel, Belarus",
          "lat": 52.4452778,
          "lng": 30.9841667
      },
      {
          "name": "Liverpool, Merseyside, UK",
          "lat": 53.41154,
          "lng": -2.990116
      },
      {
          "name": "Antwerp, Belgium",
          "lat": 51.21921589999999,
          "lng": 4.402881799999999
      },
      {
          "name": "Luhansk, Luhans'ka oblast, Ukraine, 91000",
          "lat": 48.574041,
          "lng": 39.307815
      },
      {
          "name": "Kirov, Kirov Oblast, Russia",
          "lat": 58.59999999999999,
          "lng": 49.65
      },
      {
          "name": "Gothenburg, Sweden",
          "lat": 57.70887,
          "lng": 11.97456
      },
      {
          "name": "Cheboksary, Chuvash Republic, Russia",
          "lat": 56.1333333,
          "lng": 47.2333333
      },
      {
          "name": "Ivanovo, Ivanovo Oblast, Russia",
          "lat": 57.01666669999999,
          "lng": 40.9833333
      },
      {
          "name": "Gdansk, Poland",
          "lat": 54.35202520000001,
          "lng": 18.6466384
      },
      {
          "name": "Bryansk, Bryansk Oblast, Russia",
          "lat": 53.25,
          "lng": 34.4
      },
      {
          "name": "Tver, Tverskaya oblast, Russia",
          "lat": 56.8666667,
          "lng": 35.9166667
      },
      {
          "name": "Edinburgh, Midlothian, UK",
          "lat": 55.953252,
          "lng": -3.188267
      },
      {
          "name": "Bratislava, Slovakia",
          "lat": 48.1462386,
          "lng": 17.1072618
      },
      {
          "name": "The Hague, The Netherlands",
          "lat": 52.0704978,
          "lng": 4.3006999
      },
      {
          "name": "Kursk, Kurskaya oblast, Russia",
          "lat": 51.7166667,
          "lng": 36.1833333
      },
      {
          "name": "Manchester, UK",
          "lat": 53.479251,
          "lng": -2.247926
      },
      {
          "name": "Skopje, Macedonia",
          "lat": 42.003812,
          "lng": 21.452246
      },
      {
          "name": "Magnitogorsk, Chelyabinskaya oblast, Russia",
          "lat": 53.4166667,
          "lng": 58.9666667
      },
      {
          "name": "Kaliningrad, Kaliningrad Oblast, Russia",
          "lat": 54.7,
          "lng": 20.5
      },
      {
          "name": "Tallinn, Estonia",
          "lat": 59.4426896,
          "lng": 24.7531972
      },
      {
          "name": "Szczecin, Poland",
          "lat": 53.4285438,
          "lng": 14.5528116
      },
      {
          "name": "Lyon, France",
          "lat": 45.764043,
          "lng": 4.835659
      },
      {
          "name": "Kaunas, Lithuania",
          "lat": 54.8968721,
          "lng": 23.8924264
      },
      {
          "name": "Bristol, UK",
          "lat": 51.454513,
          "lng": -2.58791
      },
      {
          "name": "Nizhny Tagil, Sverdlovskaya oblast, Russia",
          "lat": 57.91666670000001,
          "lng": 59.96666669999999
      },
      {
          "name": "Bochum, Germany",
          "lat": 51.4696168,
          "lng": 7.198734699999998
      },
      {
          "name": "Huddersfield, UK",
          "lat": 53.5933432,
          "lng": -1.8009509
      },
      {
          "name": "Bydgoszcz, Poland",
          "lat": 53.12348040000001,
          "lng": 18.0084378
      },
      {
          "name": "Bologna, Italy",
          "lat": 44.4941903,
          "lng": 11.3465185
      },
      {
          "name": "Brno, Czech Republic",
          "lat": 49.19205059999999,
          "lng": 16.6131909
      },
      {
          "name": "Vinnytsya, Vinnyts'ka oblast, Ukraine, 21000",
          "lat": 49.233083,
          "lng": 28.468217
      },
      {
          "name": "Florence, Italy",
          "lat": 43.7687324,
          "lng": 11.2569013
      },
      {
          "name": "Murmansk, Murmansk Oblast, Russia",
          "lat": 68.9930681,
          "lng": 33.1184479
      },
      {
          "name": "Ulan Ude, Republic of Buryatia, Russia",
          "lat": 51.8333333,
          "lng": 107.6
      },
      {
          "name": "Wuppertal, Germany",
          "lat": 51.2611814,
          "lng": 7.162903399999999
      },
      {
          "name": "Arkhangelsk, Arkhangelsk Oblast, Russia",
          "lat": 64.55,
          "lng": 40.5333333
      },
      {
          "name": "Toulouse, France",
          "lat": 43.604652,
          "lng": 1.444209
      },
      {
          "name": "Lublin, Poland",
          "lat": 51.2464536,
          "lng": 22.5684463
      },
      {
          "name": "Mogilev, Belarus",
          "lat": 53.9,
          "lng": 30.3333333
      },
      {
          "name": "Kherson, Khersons'ka oblast, Ukraine, 73009",
          "lat": 46.635417,
          "lng": 32.616867
      },
      {
          "name": "Smolensk, Smolensk Oblast, Russia",
          "lat": 54.7833333,
          "lng": 32.05
      },
      {
          "name": "Bilbao, Spain",
          "lat": 43.2569629,
          "lng": -2.9234409
      },
      {
          "name": "Sevastopol, Sevastopol' city, Ukraine, 99000",
          "lat": 44.61665,
          "lng": 33.525367
      },
      {
          "name": "Murcia, Spain",
          "lat": 37.98344489999999,
          "lng": -1.1298897
      },
      {
          "name": "Iaşi, Romania",
          "lat": 47.1569444,
          "lng": 27.5902778
      },
      {
          "name": "Katowice, Poland",
          "lat": 50.26489189999999,
          "lng": 19.0237815
      },
      {
          "name": "Nice, France",
          "lat": 43.696036,
          "lng": 7.265592
      },
      {
          "name": "Stavropol, Stavropol Krai, Russia",
          "lat": 45.05,
          "lng": 41.9833333
      },
      {
          "name": "Constanta, Romania",
          "lat": 44.1733333,
          "lng": 28.6383333
      },
      {
          "name": "Oryol, Orlovskaya oblast, Russia",
          "lat": 52.9666667,
          "lng": 36.0666667
      },
      {
          "name": "Catania, Italy",
          "lat": 37.5024825,
          "lng": 15.0878345
      },
      {
          "name": "Vitebsk, Belarus",
          "lat": 55.19443589999999,
          "lng": 30.1953792
      },
      {
          "name": "Kaluga, Kaluga Oblast, Russia",
          "lat": 54.5333333,
          "lng": 36.2666667
      },
      {
          "name": "Belgorod, Belgorodskaya oblast, Russia",
          "lat": 50.6166667,
          "lng": 36.5833333
      },
      {
          "name": "Zurich, Switzerland",
          "lat": 47.3686498,
          "lng": 8.539182499999999
      },
      {
          "name": "Simferopol, Crimea, Ukraine, 95000",
          "lat": 44.952117,
          "lng": 34.102417
      },
      {
          "name": "Bari",
          "lat": 41.1259135,
          "lng": 16.8721133
      },
      {
          "name": "Vladimir, Vladimirskaya oblast, Russia",
          "lat": 56.1333333,
          "lng": 40.4166667
      },
      {
          "name": "Sochi, Krasnodarskiy Kray, Russia",
          "lat": 43.4395848,
          "lng": 39.9277252
      },
      {
          "name": "Cluj, Romania",
          "lat": 46.777248,
          "lng": 23.5998899
      },
      {
          "name": "Makhachkala, Republic of Dagestan, Russia",
          "lat": 42.9783677,
          "lng": 47.4910661
      },
      {
          "name": "Galati, Romania",
          "lat": 45.42572000000001,
          "lng": 28.031044
      },
      {
          "name": "Birkenhead, Merseyside, UK",
          "lat": 53.37797399999999,
          "lng": -3.108818
      },
      {
          "name": "Timisoara, Romania",
          "lat": 45.755539,
          "lng": 21.237499
      },
      {
          "name": "Cherepovets, Vologda Oblast, Russia",
          "lat": 59.1333333,
          "lng": 37.9166667
      },
      {
          "name": "Ostrava, Czech Republic",
          "lat": 49.8412715,
          "lng": 18.2902483
      },
      {
          "name": "Bielefeld, Germany",
          "lat": 52.02159630000001,
          "lng": 8.545686
      },
      {
          "name": "Wakefield, West Yorkshire, UK",
          "lat": 53.683298,
          "lng": -1.505924
      },
      {
          "name": "Valladolid, Spain",
          "lat": 41.6529434,
          "lng": -4.7283811
      },
      {
          "name": "Saransk, Republic of Mordovia, Russia",
          "lat": 54.1833333,
          "lng": 45.1666667
      },
      {
          "name": "Cardiff, UK",
          "lat": 51.48158100000001,
          "lng": -3.17909
      },
      {
          "name": "Brasov, Romania",
          "lat": 45.655651,
          "lng": 25.6108
      },
      {
          "name": "Craiova, Romania",
          "lat": 44.32476,
          "lng": 23.813471
      },
      {
          "name": "Poltava, Poltavs'ka oblast, Ukraine, 36000",
          "lat": 49.58826699999999,
          "lng": 34.551417
      },
      {
          "name": "Tambov, Tambov Oblast, Russia",
          "lat": 52.7166667,
          "lng": 41.4333333
      },
      {
          "name": "Dudley, West Midlands, UK",
          "lat": 52.512255,
          "lng": -2.081112
      },
      {
          "name": "Wigan, UK",
          "lat": 53.54544,
          "lng": -2.637474
      },
      {
          "name": "Chita, Zabaykal'skiy Kray, Russia",
          "lat": 52.0515032,
          "lng": 113.4711906
      },
      {
          "name": "Vladikavkaz, North Ossetia-Alania, Russia",
          "lat": 43.0474558,
          "lng": 44.6658064
      },
      {
          "name": "Cherkasy, Cherkas'ka oblast, Ukraine, 18000",
          "lat": 49.444433,
          "lng": 32.059767
      },
      {
          "name": "Mannheim, Germany",
          "lat": 49.4609731,
          "lng": 8.4904166
      },
      {
          "name": "Cordova, Spain",
          "lat": 37.88472670000001,
          "lng": -4.7791517
      },
      {
          "name": "Chernihiv, Chernihivs'ka oblast, Ukraine, 14039",
          "lat": 51.4982,
          "lng": 31.28935
      },
      {
          "name": "Coventry, West Midlands, UK",
          "lat": 52.406822,
          "lng": -1.519693
      },
      {
          "name": "Horlivka, Donets'ka oblast, Ukraine, 84601",
          "lat": 48.3071,
          "lng": 38.029633
      },
      {
          "name": "Palma, Spain",
          "lat": 39.5695059,
          "lng": 2.649966
      },
      {
          "name": "Grodno, Belarus",
          "lat": 53.6666667,
          "lng": 23.8333333
      },
      {
          "name": "Bonn, Germany",
          "lat": 50.7116826,
          "lng": 7.1047327
      },
      {
          "name": "Vologda, Vologda Oblast, Russia",
          "lat": 59.2166667,
          "lng": 39.9
      },
      {
          "name": "Varna, Bulgaria",
          "lat": 43.21664519999999,
          "lng": 27.9118058
      },
      {
          "name": "Venice, Italy",
          "lat": 45.4343363,
          "lng": 12.3387844
      },
      {
          "name": "Zhytomyr, Zhytomyrs'ka oblast, Ukraine, 10000",
          "lat": 50.25465,
          "lng": 28.658667
      },
      {
          "name": "Belfast, UK",
          "lat": 54.59744329999999,
          "lng": -5.9340683
      },
      {
          "name": "Sumy, Sums'ka oblast, Ukraine, 40000",
          "lat": 50.9077,
          "lng": 34.7981
      },
      {
          "name": "Leicester, UK",
          "lat": 52.6368778,
          "lng": -1.1397592
      },
      {
          "name": "Komsomolsk on Amur, Khabarovsk Krai, Russia",
          "lat": 50.5666667,
          "lng": 137
      },
      {
          "name": "Sunderland, Tyne and Wear, UK",
          "lat": 54.906869,
          "lng": -1.383801
      },
      {
          "name": "Sandwell, Smethwick, West Midlands B66, UK",
          "lat": 52.504335,
          "lng": -1.972875
      },
      {
          "name": "Doncaster, South Yorkshire, UK",
          "lat": 53.52282,
          "lng": -1.128462
      },
      {
          "name": "Stockport, UK",
          "lat": 53.406754,
          "lng": -2.158843
      },
      {
          "name": "Kostroma, Kostromskaya oblast, Russia",
          "lat": 57.76666669999999,
          "lng": 40.9333333
      },
      {
          "name": "Vigo, Spain",
          "lat": 42.2313564,
          "lng": -8.7124471
      },
      {
          "name": "Aarhus, Denmark",
          "lat": 56.162939,
          "lng": 10.203921
      },
      {
          "name": "Brest, Belarus",
          "lat": 52.1333333,
          "lng": 23.6666667
      },
      {
          "name": "Volzhsky, Volgogradskaya oblast, Russia",
          "lat": 48.7833333,
          "lng": 44.76666669999999
      },
      {
          "name": "Taganrog, Rostovskaya oblast, Russia",
          "lat": 47.2333333,
          "lng": 38.9
      },
      {
          "name": "Białystok, Poland",
          "lat": 53.13248859999999,
          "lng": 23.1688403
      },
      {
          "name": "Nottingham, UK",
          "lat": 52.95477,
          "lng": -1.158086
      },
      {
          "name": "Petrozavodsk, Republic of Karelia, Russia",
          "lat": 61.78333329999999,
          "lng": 34.35
      },
      {
          "name": "Newcastle, Tyne and Wear, UK",
          "lat": 54.978252,
          "lng": -1.61778
      },
      {
          "name": "Gelsenkirchen, Germany",
          "lat": 51.517744,
          "lng": 7.085717199999999
      },
      {
          "name": "Bratsk, Irkutsk Oblast, Russia",
          "lat": 56.1166667,
          "lng": 101.6
      },
      {
          "name": "Dzerzhinsk, Nizhegorodskaya oblast, Russia",
          "lat": 56.2333333,
          "lng": 43.45
      },
      {
          "name": "Surgut, Khanty-Mansi Autonomous Okrug — Yugra, Russia",
          "lat": 61.25000000000001,
          "lng": 73.4166667
      },
      {
          "name": "Karlsruhe, Germany",
          "lat": 49.009148,
          "lng": 8.3799444
      },
      {
          "name": "Orsk, Orenburgskaya oblast, Russia",
          "lat": 51.2,
          "lng": 58.56666670000001
      },
      {
          "name": "Porto, Portugal",
          "lat": 41.149968,
          "lng": -8.6102426
      },
      {
          "name": "Alicante, Spain",
          "lat": 38.34521,
          "lng": -0.4809944999999999
      },
      {
          "name": "Wiesbaden, Germany",
          "lat": 50.0630804,
          "lng": 8.2433437
      },
      {
          "name": "Hull, Kingston Upon Hull, UK",
          "lat": 53.7456709,
          "lng": -0.3367413
      },
      {
          "name": "Novi Sad, Serbia",
          "lat": 45.25,
          "lng": 19.85
      },
      {
          "name": "Bolton, UK",
          "lat": 53.584441,
          "lng": -2.428619
      },
      {
          "name": "Angarsk, Irkutsk Oblast, Russia",
          "lat": 52.5802778,
          "lng": 103.9102778
      },
      {
          "name": "Sterlitamak, Republic of Bashkortostan, Russia",
          "lat": 53.6333333,
          "lng": 55.95
      },
      {
          "name": "Munster, Germany",
          "lat": 51.9514808,
          "lng": 7.625538799999999
      },
      {
          "name": "Gijon, Spain",
          "lat": 43.5452608,
          "lng": -5.6619264
      },
      {
          "name": "Ljubljana, Slovenia",
          "lat": 46.0514263,
          "lng": 14.5059655
      },
      {
          "name": "Monchengladbach, Germany",
          "lat": 51.1804572,
          "lng": 6.4428041
      },
      {
          "name": "Chemnitz, Germany",
          "lat": 50.827845,
          "lng": 12.9213697
      },
      {
          "name": "Messina, Italy",
          "lat": 38.1923323,
          "lng": 15.5555232
      },
      {
          "name": "Walsall, West Midlands, UK",
          "lat": 52.586214,
          "lng": -1.982919
      },
      {
          "name": "Malmo, Sweden",
          "lat": 55.604981,
          "lng": 13.003822
      },
      {
          "name": "Czestochowa, Poland",
          "lat": 50.8173871,
          "lng": 19.1185308
      },
      {
          "name": "Plymouth, UK",
          "lat": 50.3719165,
          "lng": -4.1360198
      },
      {
          "name": "Rotherham, South Yorkshire, UK",
          "lat": 53.4326035,
          "lng": -1.3635009
      },
      {
          "name": "Augsburg, Germany",
          "lat": 48.37144070000001,
          "lng": 10.8982552
      },
      {
          "name": "Stoke, UK",
          "lat": 53.002668,
          "lng": -2.179404
      },
      {
          "name": "Halle, Germany",
          "lat": 51.47971,
          "lng": 11.96864
      },
      {
          "name": "Verona, Italy",
          "lat": 45.4383395,
          "lng": 10.9917277
      },
      {
          "name": "Gdynia, Poland",
          "lat": 54.5188898,
          "lng": 18.5305409
      },
      {
          "name": "Strasbourg, France",
          "lat": 48.583148,
          "lng": 7.747882
      },
      {
          "name": "Ploiesti, Romania",
          "lat": 44.94,
          "lng": 26.03
      },
      {
          "name": "Nis, Serbia",
          "lat": 43.31938,
          "lng": 21.896328
      },
      {
          "name": "Yoshkar Ola, Mari El Republic, Russia",
          "lat": 56.6333333,
          "lng": 47.8666667
      },
      {
          "name": "Braunschweig, Germany",
          "lat": 52.2688736,
          "lng": 10.5267696
      },
      {
          "name": "Nantes, France",
          "lat": 47.218371,
          "lng": -1.553621
      },
      {
          "name": "Wolverhampton, West Midlands, UK",
          "lat": 52.586973,
          "lng": -2.12882
      },
      {
          "name": "Rivne, Rivnens'ka oblast, Ukraine, 33004",
          "lat": 50.6199,
          "lng": 26.251617
      },
      {
          "name": "Tirana, Albania",
          "lat": 41.326,
          "lng": 19.816
      },
      {
          "name": "Aachen, Germany",
          "lat": 50.7733179,
          "lng": 6.1021106
      },
      {
          "name": "Granada, Spain",
          "lat": 37.17648740000001,
          "lng": -3.5979291
      },
      {
          "name": "Kosice, Slovakia",
          "lat": 48.72099559999999,
          "lng": 21.2577477
      },
      {
          "name": "Krefeld, Germany",
          "lat": 51.3387609,
          "lng": 6.5853417
      },
      {
          "name": "Rybinsk, Yaroslavskaya oblast, Russia",
          "lat": 58.05,
          "lng": 38.8333333
      },
      {
          "name": "Graz, Austria",
          "lat": 47.070714,
          "lng": 15.439504
      },
      {
          "name": "Magdeburg, Germany",
          "lat": 52.130807,
          "lng": 11.628878
      },
      {
          "name": "Ivano Frankivsk, Ivano-Frankivs'ka oblast, Ukraine, 76000",
          "lat": 48.922633,
          "lng": 24.711117
      },
      {
          "name": "Kiel, Germany",
          "lat": 54.3232927,
          "lng": 10.1227652
      },
      {
          "name": "Derby, UK",
          "lat": 52.9225301,
          "lng": -1.4746186
      },
      {
          "name": "Utrecht, The Netherlands",
          "lat": 52.0901422,
          "lng": 5.109664899999999
      },
      {
          "name": "Ghent, Belgium",
          "lat": 51.053468,
          "lng": 3.73038
      },
      {
          "name": "Swansea, UK",
          "lat": 51.62144,
          "lng": -3.943645999999999
      },
      {
          "name": "Nalchik, Kabardino-Balkaria, Russia",
          "lat": 43.48412219999999,
          "lng": 43.6273607
      },
      {
          "name": "Salford, UK",
          "lat": 53.488465,
          "lng": -2.2982969
      },
      {
          "name": "Bergen, Norway",
          "lat": 60.39126279999999,
          "lng": 5.3220544
      },
      {
          "name": "Barnsley, South Yorkshire, UK",
          "lat": 53.55263,
          "lng": -1.479726
      },
      {
          "name": "Biysk, Altai Krai, Russia",
          "lat": 52.5333333,
          "lng": 85.1666667
      },
      {
          "name": "Trieste, Italy",
          "lat": 45.6535567,
          "lng": 13.7784665
      },
      {
          "name": "Oldham, UK",
          "lat": 53.5445459,
          "lng": -2.118732
      },
      {
          "name": "Aberdeen, UK",
          "lat": 57.149717,
          "lng": -2.094278
      },
      {
          "name": "Southampton, UK",
          "lat": 50.90970040000001,
          "lng": -1.4043509
      },
      {
          "name": "Lubeck, Germany",
          "lat": 53.86588560000001,
          "lng": 10.6870959
      },
      {
          "name": "Padua, Italy",
          "lat": 45.4095382,
          "lng": 11.8765537
      },
      {
          "name": "Taranto, Italy",
          "lat": 40.4692383,
          "lng": 17.2400088
      },
      {
          "name": "Bordeaux, France",
          "lat": 44.837789,
          "lng": -0.57918
      },
      {
          "name": "Bacau, Romania",
          "lat": 46.571289,
          "lng": 26.925171
      },
      {
          "name": "Montpellier, France",
          "lat": 43.610769,
          "lng": 3.876716
      },
      {
          "name": "Rochdale, UK",
          "lat": 53.614086,
          "lng": -2.161814
      },
      {
          "name": "Espoo, Finland",
          "lat": 60.20547910000001,
          "lng": 24.6558839
      },
      {
          "name": "Charleroi, Belgium",
          "lat": 50.4108095,
          "lng": 4.444643
      },
      {
          "name": "Debrecen, Hungary",
          "lat": 47.52997389999999,
          "lng": 21.6393571
      },
      {
          "name": "Solihull, West Midlands, UK",
          "lat": 52.411811,
          "lng": -1.77761
      },
      {
          "name": "Rostock, Germany",
          "lat": 54.0834186,
          "lng": 12.1004289
      },
      {
          "name": "Linz, Austria",
          "lat": 48.30694,
          "lng": 14.28583
      },
      {
          "name": "Santa Cruz, Spain",
          "lat": 28.46981,
          "lng": -16.2548558
      },
      {
          "name": "Klaipeda, Lithuania",
          "lat": 55.71080260000001,
          "lng": 21.1318065
      },
      {
          "name": "Gateshead, Tyne and Wear, UK",
          "lat": 54.95268,
          "lng": -1.603411
      },
      {
          "name": "Eindhoven, The Netherlands",
          "lat": 51.44164199999999,
          "lng": 5.4697225
      },
      {
          "name": "Split, Croatia",
          "lat": 43.5069502,
          "lng": 16.4423974
      },
      {
          "name": "Saint etienne, France",
          "lat": 45.439695,
          "lng": 4.3871779
      },
      {
          "name": "Petropavlovsk Kamchatsky, Kamchatka Krai, Russia",
          "lat": 53.038483,
          "lng": 158.6348045
      },
      {
          "name": "Rennes, France",
          "lat": 48.113475,
          "lng": -1.675708
      },
      {
          "name": "Milton Keynes, UK",
          "lat": 52.038601,
          "lng": -0.757072
      },
      {
          "name": "Yakutsk, Sakha Republic, Russia",
          "lat": 62.0380757,
          "lng": 129.7293766
      },
      {
          "name": "Banja Luka, Bosnia and Herzegovina",
          "lat": 44.76666669999999,
          "lng": 17.1833333
      },
      {
          "name": "Le Havre, France",
          "lat": 49.49437,
          "lng": 0.107929
      },
      {
          "name": "Liege, Belgium",
          "lat": 50.6325574,
          "lng": 5.5796662
      },
      {
          "name": "Halifax, UK",
          "lat": 53.7420418,
          "lng": -1.995269
      },
      {
          "name": "Northampton, UK",
          "lat": 52.240477,
          "lng": -0.9026560000000001
      },
      {
          "name": "Tampere, Finland",
          "lat": 61.49816000000001,
          "lng": 23.7610554
      },
      {
          "name": "Portsmouth, UK",
          "lat": 50.8166667,
          "lng": -1.0833333
      },
      {
          "name": "Warrington, UK",
          "lat": 53.395794,
          "lng": -2.571767
      },
      {
          "name": "Uppsala, Sweden",
          "lat": 59.85856380000001,
          "lng": 17.6389267
      },
      {
          "name": "Santander, Spain",
          "lat": 43.4609602,
          "lng": -3.8079336
      },
      {
          "name": "Bury, UK",
          "lat": 53.595024,
          "lng": -2.297151
      },
      {
          "name": "Luton, UK",
          "lat": 51.8786707,
          "lng": -0.4200255
      },
      {
          "name": "Kragujevac, Serbia",
          "lat": 44.012711,
          "lng": 20.926741
      },
      {
          "name": "St Helens, Merseyside, UK",
          "lat": 53.456307,
          "lng": -2.737095
      },
      {
          "name": "San Sebastian, Spain",
          "lat": 43.3208116,
          "lng": -1.9844474
      },
      {
          "name": "Yuzhno Sakhalinsk, Sakhalinskaya oblast, Russia",
          "lat": 46.9666667,
          "lng": 142.7333333
      },
      {
          "name": "York, UK",
          "lat": 53.9622908,
          "lng": -1.0818995
      },
      {
          "name": "Cagliari, Italy",
          "lat": 39.2154086,
          "lng": 9.1093239
      },
      {
          "name": "Geneva, Switzerland",
          "lat": 46.1983922,
          "lng": 6.142296099999999
      },
      {
          "name": "Southend, UK",
          "lat": 51.5459269,
          "lng": 0.7077123
      },
      {
          "name": "Lille, France",
          "lat": 50.62925,
          "lng": 3.057256
      },
      {
          "name": "Turku, Finland",
          "lat": 60.449249,
          "lng": 22.259239
      },
      {
          "name": "Basel, Switzerland",
          "lat": 47.557421,
          "lng": 7.592572699999999
      },
      {
          "name": "Rijeka, Croatia",
          "lat": 45.3284797,
          "lng": 14.4364051
      },
      {
          "name": "Parma, Italy",
          "lat": 44.8078657,
          "lng": 10.3295478
      },
      {
          "name": "Bath, UK",
          "lat": 51.36362930000001,
          "lng": -2.4399987
      },
      {
          "name": "Wycombe, Swanley, Greater London BR8, UK",
          "lat": 51.40132149999999,
          "lng": 0.1477863
      },
      {
          "name": "Basildon, Essex, UK",
          "lat": 51.57608399999999,
          "lng": 0.488736
      },
      {
          "name": "Pamplona, Spain",
          "lat": 42.8179879,
          "lng": -1.6441835
      },
      {
          "name": "Aalborg, Denmark",
          "lat": 57.028811,
          "lng": 9.917771
      },
      {
          "name": "Leverkusen, Germany",
          "lat": 51.04592479999999,
          "lng": 7.0192196
      },
      {
          "name": "Bournemouth, UK",
          "lat": 50.719164,
          "lng": -1.880769
      },
      {
          "name": "Peterborough, UK",
          "lat": 52.56949849999999,
          "lng": -0.2405299
      },
      {
          "name": "Szeged, Hungary",
          "lat": 46.2536169,
          "lng": 20.1461345
      },
      {
          "name": "Chelmsford, Essex, UK",
          "lat": 51.734964,
          "lng": 0.4761969999999999
      },
      {
          "name": "Brighton, Brighton and Hove, UK",
          "lat": 50.842941,
          "lng": -0.131312
      },
      {
          "name": "Aylesbury, Buckinghamshire, UK",
          "lat": 51.815606,
          "lng": -0.8084
      },
      {
          "name": "Colchester, Essex, UK",
          "lat": 51.895927,
          "lng": 0.8918740000000001
      },
      {
          "name": "Macclesfield, Cheshire East, UK",
          "lat": 53.258663,
          "lng": -2.119287
      },
      {
          "name": "Blackpool, UK",
          "lat": 53.8212725,
          "lng": -3.0554531
      },
      {
          "name": "Perugia, Italy",
          "lat": 43.1107009,
          "lng": 12.389172
      },
      {
          "name": "Balti, Moldova",
          "lat": 47.75494,
          "lng": 27.913
      },
      {
          "name": "Grenoble, France",
          "lat": 45.188529,
          "lng": 5.724524
      },
      {
          "name": "Dundee, UK",
          "lat": 56.462018,
          "lng": -2.970721
      },
      {
          "name": "Norilsk, Krasnoyarsk Krai, Russia",
          "lat": 69.33333329999999,
          "lng": 88.21666669999999
      }
  ]
  end
end
