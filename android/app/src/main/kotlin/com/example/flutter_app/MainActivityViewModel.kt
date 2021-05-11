package com.example.flutter_app

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

class MainActivityViewModel : ViewModel() {
    val liveData = MutableLiveData<String>()

    fun getSomeData() {
        viewModelScope.launch {
            getData()
        }
    }

    private suspend fun getData() = withContext(Dispatchers.IO) {
        delay(200)
        withContext(Dispatchers.Main) {
            liveData.value = " data from android native"
        }
    }
}