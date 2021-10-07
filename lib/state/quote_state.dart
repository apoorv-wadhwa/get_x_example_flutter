import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:getxstatemanagement/repository/repository.dart';

class Quote {
   String quote;

  Quote({this.quote});
}

class QuoteState extends GetxController {
  var loading = false.obs;
  var quote = Quote().obs;
  var showError = false.obs;
  var errorString = ''.obs;


  Future fetchQuote() async {
    final QuotesRepository  quoteRepo = QuotesRepository();
    try{
      loading.value = true;
      final responseFromQuoteRepository = await quoteRepo.getQuote();
      if(responseFromQuoteRepository != null && responseFromQuoteRepository.isNotEmpty) {
        quote.update((val) {
          val.quote = responseFromQuoteRepository['contents']['quotes'][0]['quote'];
        });
        if(quote.value.quote != null && quote.value.quote.isNotEmpty) {
          loading.value = false;
          errorString.value = '';
          showError.value = false;
        }
        else {
          errorString.value = 'No quotes could be found at the moment';
          showError.value = true;
          loading.value = false;
        }
      }
      else {
        errorString.value = 'No quotes could be found at the moment';
        showError.value = true;
        loading.value = false;
      }


    }
    catch(error) {
      print('QuoteState fetchQuote error $error');
      errorString.value = 'Some error occurred, please try again later!';
      showError.value = true;
      loading.value = false;
    }
  }

}