/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file           : main.c
  * @brief          : Main program body
  ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; Copyright (c) 2020 STMicroelectronics.
  * All rights reserved.</center></h2>
  *
  * This software component is licensed by ST under BSD 3-Clause license,
  * the "License"; You may not use this file except in compliance with the
  * License. You may obtain a copy of the License at:
  *                        opensource.org/licenses/BSD-3-Clause
  *
  ******************************************************************************
  */
/* USER CODE END Header */
/* Includes ------------------------------------------------------------------*/
#include "main.h"

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */
#include "stdbool.h"
/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private define ------------------------------------------------------------*/
/* USER CODE BEGIN PD */
/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/

/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
void SystemClock_Config(void);
static void MX_GPIO_Init(void);
/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Private user code ---------------------------------------------------------*/
/* USER CODE BEGIN 0 */
struct DebouncedGpio {
    uint16_t pin;
    GPIO_TypeDef* port;
    uint32_t active_counts_required;
    uint32_t active_counts;
    uint32_t inactive_counts_required;
    uint32_t inactive_counts;
    GPIO_PinState active_state;
};

enum GpioState {
    ACTIVE,
    TRANSITIONING,
    INACTIVE,
};

enum GpioState get_state(struct DebouncedGpio* pin) {
    if (HAL_GPIO_ReadPin(pin->port, pin->pin) == pin->active_state) {
        pin->active_counts++;
        pin->inactive_counts = 0;
    } else {
        pin->active_counts = 0;
        pin->inactive_counts++;
    }
    if (pin->active_counts >= pin->active_counts_required && pin->inactive_counts == 0) {
        return ACTIVE;
    }
    if (pin->inactive_counts >= pin->inactive_counts_required && pin->active_counts == 0) {
        return INACTIVE;
    }
    return TRANSITIONING;
}

void reset(struct DebouncedGpio* pin) {
	pin->active_counts = 0;
	pin->inactive_counts = 0;
}


enum RelayState {
    DISABLED,
    AUDIO,
    BUTTON,
};

struct Relay {
    uint16_t pin;
    GPIO_TypeDef* port;
    uint16_t led_pin;
    GPIO_TypeDef* led_port;
    uint32_t disabled_for;
    enum RelayState state;
};

void enable_relay(struct Relay* relay, bool audio) {
    if (audio && relay->disabled_for != 0) return;
    HAL_GPIO_WritePin(relay->port, relay->pin, GPIO_PIN_SET);
    HAL_GPIO_WritePin(relay->led_port, relay->led_pin, GPIO_PIN_RESET);
    relay->state = audio ? AUDIO : BUTTON;
}

void disable_relay(struct Relay* relay) {
    HAL_GPIO_WritePin(relay->port, relay->pin, GPIO_PIN_RESET);
    HAL_GPIO_WritePin(relay->led_port, relay->led_pin, GPIO_PIN_SET);
    relay->disabled_for = 4 * 1000;
    relay->state = DISABLED;
}

void poll_relay(struct Relay* relay) {
    if (relay->disabled_for > 0)
        relay->disabled_for--;
}
/* USER CODE END 0 */

/**
  * @brief  The application entry point.
  * @retval int
  */
int main(void)
{
  /* USER CODE BEGIN 1 */

  /* USER CODE END 1 */

  /* MCU Configuration--------------------------------------------------------*/

  /* Reset of all peripherals, Initializes the Flash interface and the Systick. */
  HAL_Init();

  /* USER CODE BEGIN Init */

  /* USER CODE END Init */

  /* Configure the system clock */
  SystemClock_Config();

  /* USER CODE BEGIN SysInit */

  /* USER CODE END SysInit */

  /* Initialize all configured peripherals */
  MX_GPIO_Init();
  /* USER CODE BEGIN 2 */
  struct DebouncedGpio button = {
      .pin = BUTTON_Pin,
      .port = BUTTON_GPIO_Port,
	  .active_counts = 0,
      .active_counts_required = 20,
	  .inactive_counts = 0,
      .inactive_counts_required = 20,
      .active_state = GPIO_PIN_RESET,
  };
  struct DebouncedGpio audio_en = {
      .pin = AUDIO_EN_Pin,
      .port = AUDIO_EN_GPIO_Port,
	  .active_counts = 0,
      .active_counts_required = 20,
	  .inactive_counts = 0,
      .inactive_counts_required = 60 * 1000,
      .active_state = GPIO_PIN_RESET,
  };
  struct Relay relay = {
      .pin = RELAY_1_Pin,
      .port = RELAY_1_GPIO_Port,
      .led_pin = LED_Pin,
      .led_port = LED_GPIO_Port,
      .disabled_for = 1000,
      .state = DISABLED,
  };

  bool button_state = false;
  /* USER CODE END 2 */

  /* Infinite loop */
  /* USER CODE BEGIN WHILE */
  while (1)
  {
      poll_relay(&relay);

	  enum GpioState btn = get_state(&button);
	  if (btn == ACTIVE && button_state == false) {
		  reset(&audio_en);
		  button_state = true;
		  if (relay.state) {
			  disable_relay(&relay);
		  } else {
			  enable_relay(&relay, false);
		  }
	  } else if (btn == INACTIVE && button_state == true) {
		  button_state = false;
	  }

	  enum GpioState aud_en = get_state(&audio_en);
      if (aud_en == ACTIVE && relay.state == DISABLED) {
          enable_relay(&relay, true);
      } else if (aud_en == INACTIVE && relay.state == AUDIO) {
          disable_relay(&relay);
      }

	  HAL_Delay(1);
    /* USER CODE END WHILE */
    /* USER CODE BEGIN 3 */
  }
  /* USER CODE END 3 */
}

/**
  * @brief System Clock Configuration
  * @retval None
  */
void SystemClock_Config(void)
{
  RCC_OscInitTypeDef RCC_OscInitStruct = {0};
  RCC_ClkInitTypeDef RCC_ClkInitStruct = {0};

  /** Configure the main internal regulator output voltage
  */
  __HAL_PWR_VOLTAGESCALING_CONFIG(PWR_REGULATOR_VOLTAGE_SCALE1);
  /** Initializes the RCC Oscillators according to the specified parameters
  * in the RCC_OscInitTypeDef structure.
  */
  RCC_OscInitStruct.OscillatorType = RCC_OSCILLATORTYPE_HSI;
  RCC_OscInitStruct.HSIState = RCC_HSI_ON;
  RCC_OscInitStruct.HSICalibrationValue = RCC_HSICALIBRATION_DEFAULT;
  RCC_OscInitStruct.PLL.PLLState = RCC_PLL_NONE;
  if (HAL_RCC_OscConfig(&RCC_OscInitStruct) != HAL_OK)
  {
    Error_Handler();
  }
  /** Initializes the CPU, AHB and APB buses clocks
  */
  RCC_ClkInitStruct.ClockType = RCC_CLOCKTYPE_HCLK|RCC_CLOCKTYPE_SYSCLK
                              |RCC_CLOCKTYPE_PCLK1|RCC_CLOCKTYPE_PCLK2;
  RCC_ClkInitStruct.SYSCLKSource = RCC_SYSCLKSOURCE_HSI;
  RCC_ClkInitStruct.AHBCLKDivider = RCC_SYSCLK_DIV1;
  RCC_ClkInitStruct.APB1CLKDivider = RCC_HCLK_DIV1;
  RCC_ClkInitStruct.APB2CLKDivider = RCC_HCLK_DIV1;

  if (HAL_RCC_ClockConfig(&RCC_ClkInitStruct, FLASH_LATENCY_0) != HAL_OK)
  {
    Error_Handler();
  }
}

/**
  * @brief GPIO Initialization Function
  * @param None
  * @retval None
  */
static void MX_GPIO_Init(void)
{
  GPIO_InitTypeDef GPIO_InitStruct = {0};

  /* GPIO Ports Clock Enable */
  __HAL_RCC_GPIOA_CLK_ENABLE();

  /*Configure GPIO pin Output Level */
  HAL_GPIO_WritePin(GPIOA, RELAY_1_Pin|RELAY_2_Pin, GPIO_PIN_RESET);
  HAL_GPIO_WritePin(GPIOA, LED_Pin, GPIO_PIN_SET);

  /*Configure GPIO pins : RELAY_1_Pin RELAY_2_Pin */
  GPIO_InitStruct.Pin = RELAY_1_Pin|RELAY_2_Pin;
  GPIO_InitStruct.Mode = GPIO_MODE_OUTPUT_PP;
  GPIO_InitStruct.Pull = GPIO_NOPULL;
  GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_LOW;
  HAL_GPIO_Init(GPIOA, &GPIO_InitStruct);

  /*Configure GPIO pins : BUTTON_Pin AUDIO_EN_Pin */
  GPIO_InitStruct.Pin = BUTTON_Pin|AUDIO_EN_Pin;
  GPIO_InitStruct.Mode = GPIO_MODE_INPUT;
  GPIO_InitStruct.Pull = GPIO_PULLUP;
  HAL_GPIO_Init(GPIOA, &GPIO_InitStruct);

  /*Configure GPIO pin : LED_Pin */
  GPIO_InitStruct.Pin = LED_Pin;
  GPIO_InitStruct.Mode = GPIO_MODE_OUTPUT_OD;
  GPIO_InitStruct.Pull = GPIO_NOPULL;
  GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_LOW;
  HAL_GPIO_Init(LED_GPIO_Port, &GPIO_InitStruct);

}

/* USER CODE BEGIN 4 */

/* USER CODE END 4 */

/**
  * @brief  This function is executed in case of error occurrence.
  * @retval None
  */
void Error_Handler(void)
{
  /* USER CODE BEGIN Error_Handler_Debug */
  /* User can add his own implementation to report the HAL error return state */

  /* USER CODE END Error_Handler_Debug */
}

#ifdef  USE_FULL_ASSERT
/**
  * @brief  Reports the name of the source file and the source line number
  *         where the assert_param error has occurred.
  * @param  file: pointer to the source file name
  * @param  line: assert_param error line source number
  * @retval None
  */
void assert_failed(uint8_t *file, uint32_t line)
{
  /* USER CODE BEGIN 6 */
  /* User can add his own implementation to report the file name and line number,
     tex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */
  /* USER CODE END 6 */
}
#endif /* USE_FULL_ASSERT */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
